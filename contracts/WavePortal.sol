// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
	uint totalWaves;
	uint private seed;

	struct Wave {
		address waver;
		string message;
		uint timestamp;
	}

	Wave[] waves;

	event NewWave(address indexed from, uint timestamp, string message);

	
	/* 
	 An address => uint mapping, meaning I can associate an address
	 with a number! Storing the address the last time teh user waved at us
	*/
	mapping(address => uint) public lastWavedAt;

	constructor() payable {
		console.log("We have been constructed!");
	}	

	function wave(string memory _message) public {
		// Require msg.sender to wait atleast 30 seconds before waving
		require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Wait 30 seconds");

		// Update current timestamp for last wave
		lastWavedAt[msg.sender] = block.timestamp;

		totalWaves += 1;
		console.log("%s waved w/ message %s", msg.sender, _message);
		console.log("Got message: %s", _message);
		waves.push(Wave(msg.sender, _message, block.timestamp));

		// Generate a PSEUDO random number in the range 100.
		uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
		console.log("Random # generated: %s", randomNumber);

		// Set the generated random number as the seed for the next wave.
		seed = randomNumber;

		// Give a 50% chance that the user wins the prize.
		if (randomNumber < 50) {
			console.log("%s won!", msg.sender);
			// The same code we had before to send the prize
			uint prizeAmount = 0.0001 ether;
			require(prizeAmount <= address(this).balance, "Contract doesn't have money AHHHH");
			(bool success,) = (msg.sender).call{value: prizeAmount}("");
			require(success, "Failed to send money");
		}

		emit NewWave(msg.sender, block.timestamp, _message);
	}

	function getAllWaves() view public returns (Wave[] memory) {
		return waves;
	}

	function getTotalWaves() view public returns (uint) {
		return totalWaves;
	}
}