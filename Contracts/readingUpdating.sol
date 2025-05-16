// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract simpleStorage{
    // declaring the variable 
    uint256 public  num;

    // function to set the fav number
    function store(uint256 _num) public {
        num = _num;
    }

    //function to retrieve the fav number
    function get() public view returns (uint256){
        return num;
    }

    // function to reset the fav number
    function reset() public{
       delete num; 
    }
}