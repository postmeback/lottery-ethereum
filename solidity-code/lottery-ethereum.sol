// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address[] public participants;
    address public luckyWinner;
    uint public constant MAX_PARTICIPANTS = 10;

    // Function to allow participants to enter
    function enterLottery() external {
        require(participants.length < MAX_PARTICIPANTS, "Lottery is full");
        require(!isDuplicate(msg.sender), "Address already entered");

        participants.push(msg.sender);
    }

    // Function to check for duplicate addresses
    function isDuplicate(address _addr) private view returns (bool) {
        for (uint i = 0; i < participants.length; i++) {
            if (participants[i] == _addr) {
                return true;
            }
        }
        return false;
    }

    // Function to pick the lucky winner
    function pickWinner() external {
        require(participants.length == MAX_PARTICIPANTS, "Not enough participants");

        uint randomIndex = uint(
            keccak256(abi.encodePacked(block.timestamp, block.difficulty, participants))
        ) % participants.length;

        luckyWinner = participants[randomIndex];
    }

    // Get the lucky winner
    function getWinner() external view returns (address) {
        require(luckyWinner != address(0), "No winner yet");
        return luckyWinner;
    }

    function getAllAddresses() public view returns (address[] memory) {
        return participants;
    }
}
