// SPDX-License-Identifier: MIT	
pragma solidity ^0.8.8;

contract Poll {
    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
        // address delegate;
    }

    //modifer
    modifier onlyOwner () {
      require(msg.sender == owner);
      _;
    }

    /* struct Proposal {
        uint voteCount; // could add other data about proposal
    } */
    address public owner;
    mapping(address => Voter) public voters;
    uint[4] public proposals;

    // Create a new ballot with 4 different proposals.
    constructor() {
        owner = msg.sender;
        voters[owner].weight = 1;
    }

    /// Give $(toVoter) the right to vote on this ballot.
    /// May only be called by $(owner).
    function register(address toVoter) public onlyOwner{
        if(voters[toVoter].weight != 0) revert();
        voters[toVoter].weight = 1;
        voters[toVoter].voted = false;
    }

    /// Give a single vote to proposal $(toProposal).
    function vote(uint8 toProposal) public {
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= 4 || sender.weight == 0) revert();
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal] += sender.weight;
    }

    function winningProposal() public view returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < 4; prop++){
            if (proposals[prop] > winningVoteCount) {
                winningVoteCount = proposals[prop];
                _winningProposal = prop;
            }
        }
    }
}