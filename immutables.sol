// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract immutables{
    address public  immutable myAddr;
    uint256 public immutable MYnumber;

    constructor(uint256 _MYnumber){
        myAddr = msg.sender;
        MYnumber = _MYnumber;
    }
}