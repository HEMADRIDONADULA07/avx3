//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract hemadri is ERC20 {
    address public owner;

    constructor(string memory name, string memory symbol, uint initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    modifier hasEnoughBalance(uint amount) {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _;
    }

    modifier validAddress(address account) {
        require(account != address(0), "Invalid address");
        _;
    }

    function Mint(address account, uint amount) public onlyOwner validAddress(account) {
        _mint(account, amount);
    }

    function TransferTokens(address to, uint amount) public hasEnoughBalance(amount) {
        _transfer(msg.sender, to, amount);
    }

    function BurnTokens(uint amount) public hasEnoughBalance(amount) {
        _burn(msg.sender, amount);
    }
}