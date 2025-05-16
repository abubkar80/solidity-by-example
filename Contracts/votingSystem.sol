// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// constant and immutable are similer 
// in this contract i am going to see how to use constant and immutable variables 

contract votingSystem{
    // set the max voters using constant keyword 
    uint256 public constant MAX_VOTERS = 100;

    // set the voting deadline using immutable
    uint256 public immutable votingDeadline;

    bool public isClosed;

    uint256 public voteCount;

    mapping(address => bool) public  hasVoted;

    constructor(){
        votingDeadline = block.timestamp + 1 days;
    }

     function closeVoting() public {
        require(!isClosed, "it is already close");
    
        isClosed = true;
    }

    // check if the vote is open 
    function   isVotingOpen() public view returns (bool){
        return block.timestamp < votingDeadline && !isClosed ;
    }

    // function to cast vote
    function vote() public {
        require(isVotingOpen(),"Has voted");
        require(!hasVoted[msg.sender],"Already Voted");
        require(voteCount< MAX_VOTERS, "Max voters reached");
        require(!isClosed, "it has been close");

        hasVoted[msg.sender] = true;

        voteCount++;
    }

}