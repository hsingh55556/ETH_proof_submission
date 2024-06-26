// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MyToken {
    // Public variables to store the token details
    string public tokenName = "discrete";
    string public tokenAbb = "DSC";
    uint8 public decimals = 18; // Common practice for token decimals
    uint public totalSupply = 0;

    // Mapping to store the balances of addresses
    mapping(address => uint) public balances;

    // Owner address
    address public owner;

    // Events to emit for tracking transactions
    event Transfer(address indexed from, address indexed to, uint value);
    event Mint(address indexed to, uint value);
    event Burn(address indexed from, uint value);

    // Modifier to check if the sender is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Constructor to set the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to mint new tokens
    function mint(address _address, uint _value) public onlyOwner {
        totalSupply += _value;
        balances[_address] += _value;
        emit Mint(_address, _value);
        emit Transfer(address(0), _address, _value); // Minting is effectively a transfer from address(0)
    }

    // Function to burn tokens
    function burn(address _address, uint _value) public onlyOwner {
        require(balances[_address] >= _value, "Insufficient balance to burn");
        totalSupply -= _value;
        balances[_address] -= _value;
        emit Burn(_address, _value);
        emit Transfer(_address, address(0), _value); // Burning is effectively a transfer to address(0)
    }

    // Function to transfer tokens
    function transfer(address _to, uint _value) public returns (bool) {
        require(_to != address(0), "check add");
        require(balances[msg.sender] >= _value, "Insufficient balance");

        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}