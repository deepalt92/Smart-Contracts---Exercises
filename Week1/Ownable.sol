//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable{
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier OnlyOwner{
        require(msg.sender == owner, "Only owner is allowed!");
        _;
    }
}
