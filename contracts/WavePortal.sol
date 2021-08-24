// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
	uint totalWaves;

	event NewWave(address indexed from, uint timestamp, string message);

	struct Wave {
		address waver;
		string message;
		uint timestamp;
	}

	Wave[] waves;

	constructor() {
		console.log("We have been constructed!");
	}	

	function wave(string memory _message) public {
		totalWaves += 1;
		console.log("%s waved w/ message %s", msg.sender, _message);

		waves.push(Wave(msg.sender, _message, block.timestamp));

		emit NewWave(msg.sender, block.timestamp, _message);
	}

	function getAllWaves() view public returns (Wave[] memory) {
		return waves;
	}

	function getTotalWaves() view public returns (uint) {
		return totalWaves;
	}
}