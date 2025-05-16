// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// constant and immutable are similer 
// in this contract i am going to see how to use constant and immutable variables 

contract votingSystem{
    // set the max voters using constant keyword 
    uint256 public constant MAX_VOTERS = 100;

    // set the voting deadline using immutable
    uint256 public immutable votingDeadline;

    // create variable to store is voting is open or not
    bool public isClosed;

    // create a varialble to track voters count
    uint256 public voteCount;

    //check if person has voted
    mapping(address => bool) public  hasVoted;

    // constructor to set the deadline
    constructor(){
        votingDeadline = block.timestamp + 1 days;
    }

    // function to check if the voting is closed
    function closeVoting() public {
        require(!isClosed, "it is already close");
        isClosed = true;
    }

    // check if the vote is open and close when close
    function   isVotingOpen() public view returns (bool){
        return block.timestamp < votingDeadline && !isClosed ;
    }

    // function to cast vote
    function vote() public {
        // check if the voting is open 
        require(isVotingOpen(),"Has voted");

        // check if the deployer already voted
        require(!hasVoted[msg.sender],"Already Voted");

        // making sure the MAX_VOTERS is not exceeded
        require(voteCount< MAX_VOTERS, "Max voters reached");

        // checking if the vote is close or not
        require(!isClosed, "it has been close");

        // changing the state of the sender when voted
        hasVoted[msg.sender] = true;

        // increaing the voting count
        voteCount++;
    }

}