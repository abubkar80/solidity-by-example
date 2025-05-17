// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// constant and immutable are similer 
// in this contract i am going to see how to use constant and immutable variables 

contract votingSystem{
    event voteCast(address indexed voter, uint256 indexed candidateId);
    uint256 public numCandidates;
    mapping(uint256 => uint256) public votesReceived;
    // set the max voters using constant keyword 
    uint256 public constant MAX_VOTERS = 100;

    // set the voting deadline using immutable
    uint256 public immutable votingDeadline;

    // create variable to store is voting is open or not
    bool public isClosed;

    // create a varialble to track voters count
    uint256 public voteCount;

    // set the owner of the contract
    address public owner;

    //check if person has voted
    mapping(address => bool) public  hasVoted;

    // constructor to set the deadline
    constructor(uint256 _numCandidates){
        votingDeadline = block.timestamp + 1 days;
        owner = msg.sender;
        numCandidates = _numCandidates;
    }

    // function to check if the voting is closed
    function closeVoting() public {
        require(!isClosed, "it is already close");
        require(msg.sender == owner,"only the owner can close the voting system");
        isClosed = true;
    }

    // check if the vote is open and close when close
    function   isVotingOpen() public view returns (bool){
        return block.timestamp < votingDeadline && !isClosed ;
    }

    // function to cast vote
    function vote( uint256 candidateId ) public {
        require(candidateId < numCandidates,"Invalid candidate id");
        // check if the voting is open 
        require(isVotingOpen(),"Voting is not open");

        // check if the deployer already voted
        require(!hasVoted[msg.sender],"Already Voted");

        // making sure the MAX_VOTERS is not exceeded
        require(voteCount< MAX_VOTERS, "Max voters reached");

        // changing the state of the sender when voted
        hasVoted[msg.sender] = true;

        votesReceived[candidateId]++;

        // increaing the voting count
        voteCount++;

        // emit voteCast(msg.sender, candidateId);

        emit voteCast(msg.sender, candidateId);
    }

    function getResult(uint256 candidateId) public view returns (uint256){
        require(candidateId < numCandidates, "Invalid Candidate");
        return votesReceived[candidateId];
    }

    function getWinner() public view returns (uint256 winnerId){
        uint256 maxVotes = 0;
        winnerId = 0; 
        for(uint256 i=1 ; i< numCandidates; i++){
            if (votesReceived[i]>maxVotes){
                maxVotes = votesReceived[i];
                winnerId= i;
            }
        }
    }

    function getTiedWinners() public view returns (uint256 [] memory){
        uint256 maxVotes = 0;
        for (uint256 i= 0; i<numCandidates ; i++){
            if(votesReceived[i] > maxVotes){
                maxVotes = votesReceived[i];
            }
        }

        uint256 count = 0;
        for (uint256 i = 0; i<numCandidates ; i++){
            if (votesReceived[i] == maxVotes){
                count++;
            }
        }

        uint256[] memory tiedWinners = new  uint256[](count);

        uint256 index = 0 ;
        for (uint256 i=0 ; i<numCandidates ; i++){
            if(votesReceived[i] == maxVotes){
                tiedWinners[index]= i;
                index++;
            }
        }

        return tiedWinners;
    }


}