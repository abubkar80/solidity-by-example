// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract EtherUnits{
    uint256 public oneWei = 1 wei;
    // one wei = 2 wei
    bool public isOneWei = (oneWei == 1 wei);

    uint256 public oneGwei = 1 gwei;
    //1 gwei = 10e9
    bool public isOnGwei = (oneGwei == 1e9);

    uint256 public oneEther = 1 ether;
    // 1 ether = 10e18
    bool public isEther = ( oneEther == 1e18);

}