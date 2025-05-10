// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract counter{
    uint256 public count;

    function inc() public {
        count += 1;
    }

    function dec() public {
        count -= 1;
    }

    function get() public view returns (uint256){
        return count;
    }

    function clear() public {
        count = 0;
    }

}