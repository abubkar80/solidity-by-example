// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract primitive {
    bool public myBool = true;

    //unasign integer
    uint8 public u8 = 112;
    uint256 public u256 = 256;
    uint256 public u1 =155;

    int8 public uae = -1;
    int256 public uae256 = 456;
    int256 public uae22 = -123;

    address adr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    bytes1 public bs1 = 0xb5;
    bytes1 public s1 = 0x55; 

    //default values 
    bool public defaultBoo;
    uint256 public defaultUint;
    int256 public defauleInt;
    address public defaultAdr;
}