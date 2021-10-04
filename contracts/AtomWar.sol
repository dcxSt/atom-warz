// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract AtomWar {
    mapping (address => bool) public electrons;
    mapping (address => bool) public neutrons;
    mapping (address => bool) public protons;
    address[] electronMembers;
    address[] neutronMembers;
    address[] protonMembers;
    uint256 electronScore;
    uint256 neutronScore;
    uint256 protonScore;

    constructor() {
        console.log("The stupid contract has been initiated");
    }

    // join a gang
    // gangid {0:"electron", 1:"neutron", 2:"proton"}
    function joinGang(uint8 gangId) public {
        require(!electrons[msg.sender], "You are already a member of the electron gang.");
        require(!neutrons[msg.sender], "You are already a member of the neutron gang.");
        require(!protons[msg.sender], "You are already a member of the proton gang.");
        require(gangId <= 2 && gangId >= 0); // the gangId can be 0, 1 or 2
        if (gangId == 0) {
            electronMembers.push(msg.sender);
            electrons[msg.sender] = true;
        } else if (gangId == 1) {
            neutronMembers.push(msg.sender);
            neutrons[msg.sender] = true;
        } else { // gangId == 2
            protonMembers.push(msg.sender);
            protons[msg.sender] = true;
        }
    }

    // shooting increments your team's score by 1
    function shoot() public {
        require(electrons[msg.sender] || neutrons[msg.sender] || protons[msg.sender], "You must join a gang before you can shoot.");
        if (electrons[msg.sender]) {
            electronScore ++;
        } else if (neutrons[msg.sender]) {
            neutronScore ++;
        } else {
            protonScore ++;
        }
    }

    // get the scores of each team
    function getScores() public view returns (uint256, uint256, uint256) {
        return (electronScore, neutronScore, protonScore);
    }

    // view all the team members of a gang
    function viewMembers(uint8 gangId) public view returns (address[] memory) {
        require(gangId>=0 && gangId<=2, "gangId must take values 0, 1, or 2");
        if (gangId == 0) {
            return electronMembers;
        } else if (gangId == 1) {
            return neutronMembers;
        } 
        return protonMembers;
    }
}
