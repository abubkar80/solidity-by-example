// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// constant and immutable are similer 
// in this contract i am going to see how to use constant and immutable variables 

contract votingSystem{
    event voteCast(address indexed voter, uint256 indexed candidateId);
    uint256 public numCandidates;

    mapping( uint256 => mapping(uint256 => Candidate)) public candidates;
    mapping( uint256 => mapping(address => bool)) public isRegistered;
    mapping( uint256 => mapping(address => bool)) public  hasVoted;
    mapping( uint256 => uint256) public voteCount;

    // set the max voters using constant keyword 
    uint256 public constant MAX_VOTERS = 100;

    // set the voting deadline using immutable
    uint256 public immutable votingDeadline;

    // create variable to store is voting is open or not
    bool public isClosed;

    // create a varialble to track voters count
    

    // set the owner of the contract
    address public owner;
    uint256 public electionId;

    //check if person has voted

    struct Candidate{
        string name;
        uint256 voteCount;
    }

    // constructor to set the deadline
    constructor(string[] memory _candidateNames){
        votingDeadline = block.timestamp + 1 days;
        owner = msg.sender;
        numCandidates = _candidateNames.length;

        for(uint256 i = 0; i < numCandidates ; i++){
            candidates[electionId][i] = Candidate(_candidateNames[i], 0);
        }
    }

    function registerVoter(address _voter) public {
        require(msg.sender == owner, "only owner can register a voter");
        require(!isRegistered[electionId][_voter],"already registered");

        isRegistered[electionId][_voter] = true;
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
        require(isRegistered[electionId][msg.sender], "you are not registered to vote");
        // check if the deployer already voted
        require(!hasVoted[electionId][msg.sender],"Already Voted");
        // making sure the MAX_VOTERS is not exceeded
        require(voteCount[electionId]< MAX_VOTERS, "Max voters reached");

        // changing the state of the sender when voted
        hasVoted[electionId][msg.sender] = true;

        candidates[electionId][candidateId].voteCount++;

        // increaing the voting count
        voteCount[electionId]++;
        emit voteCast(msg.sender, candidateId);
    }

    function getResult(uint256 candidateId) public view returns (uint256){
        require(candidateId < numCandidates, "Invalid Candidate");
        return candidates[electionId][candidateId].voteCount;
    }

    function getWinner() public view returns (uint256 winnerId){
        uint256 maxVotes = 0;
        winnerId = 0; 
        for(uint256 i=1 ; i< numCandidates; i++){
            if (candidates[electionId][i].voteCount>maxVotes){
                maxVotes = candidates[electionId][i].voteCount;
                winnerId= i;
            }
        }

        return winnerId;
    }

    function getTiedWinners() public view returns (uint256 [] memory){
        uint256 maxVotes = 0;
        for (uint256 i= 0; i<numCandidates ; i++){
            if(candidates[electionId][i].voteCount > maxVotes){
                maxVotes = candidates[electionId][i].voteCount;
            }
        }

        uint256 count = 0;
        for (uint256 i = 0; i<numCandidates ; i++){
            if (candidates[electionId][i].voteCount == maxVotes){
                count++;
            }
        }

        uint256[] memory tiedWinners = new  uint256[](count);

        uint256 index = 0 ;
        for (uint256 i=0 ; i<numCandidates ; i++){
            if(candidates[electionId][i].voteCount == maxVotes){
                tiedWinners[index]= i;
                index++;
            }
        }

        return tiedWinners;
    }

    function getCandidateName(uint256 candidateId) public view returns (string memory){
        require(candidateId < numCandidates, "invalid candidate ID");
        return candidates[electionId][candidateId].name;
    }

    function getAllCandidate() public view returns(Candidate[] memory){
        Candidate[] memory result = new  Candidate[](numCandidates);
        for(uint256 i = 0 ; i < numCandidates; i++){
            result[i] = candidates[electionId][i];
        }

        return result;
    }

    function resetElection(string[] memory _candidateNames) public {
        require(msg.sender == owner, "only owner can reset election");
        electionId++;
        numCandidates = _candidateNames.length;
        isClosed = false;

        for(uint256 i= 0; i < numCandidates; i++){
            candidates[electionId][i] = Candidate(_candidateNames[i], 0);
        }

        voteCount[electionId] = 0;
    }

}