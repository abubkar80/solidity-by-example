// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Gas {
    uint256 i = 0;

    function forever() public {
        while (true) {
            i +=1;
        }
    }
}