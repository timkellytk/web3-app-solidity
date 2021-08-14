import { ethers } from "hardhat";

async function main() {
  const [owner, randoPerson] = await ethers.getSigners();
  const waveContractFactory = await ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();

  await waveContract.deployed();
  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  await waveContract.getTotalWaves();

  const waveTxn = await waveContract.wave();
  await waveTxn.wait();

  await waveContract.getTotalWaves();

  const randoWaveTxn = await waveContract.connect(randoPerson).wave();
  await randoWaveTxn.wait();

  await waveContract.getTotalWaves();

  // Custom solidity code
  const randoBiggestWave = await waveContract
    .connect(randoPerson)
    .scoreBiggestWave();
  await randoBiggestWave.wait();

  await waveContract.getBiggestWave();
}

main()
  .then(() => {
    process.exit(0);
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
