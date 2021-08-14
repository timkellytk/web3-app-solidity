// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
	uint totalWaves;
	address biggestWaveAddy;
	constructor() {
		console.log("WavePortal created");
	}	

	function wave() public {
		totalWaves += 1;
		console.log("%s is waved!", msg.sender);
	}

	function scoreBiggestWave() public {
		biggestWaveAddy = msg.sender;
		console.log("%s scored the biggest wave!", biggestWaveAddy);
	}

	function getTotalWaves() public view returns (uint) {
		console.log("We have %d total waves", totalWaves);
		return totalWaves;
	}

	function getBiggestWave() public view returns (address) {
		console.log("We have %s as the biggest wave recorded", biggestWaveAddy);
		return biggestWaveAddy;
	}
}