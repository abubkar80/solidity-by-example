// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// constant and immutable are similer 
// in this contract i am going to see how to use constant and immutable variables 

contract votingSystem{
    // set the max voters using constant keyword 
    uint256 public constant MAX_VOTERS = 100;

    // set the voting deadline using immutable
    uint256 public immutable votingDeadline;

    constructor(){
        votingDeadline = block.timestamp + 1 days;
    }

    // check if the vote is open 
    function   isVotingOpen() public view returns (bool){
        return block.timestamp < votingDeadline ;
    }

    // function to [cast vote
    function vote(){
        require(isVotingOpen());
        
    }
}