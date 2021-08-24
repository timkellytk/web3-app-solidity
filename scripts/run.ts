import { ethers } from "hardhat";

async function main() {
  const waveContractFactory = await ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed;
  console.log("Contract addy:", waveContract.address);

  const count = await waveContract.getTotalWaves();
  console.log(count.toNumber());

  const waveTxn = await waveContract.wave("A message!");
  await waveTxn.wait();

  const waveTxn2 = await waveContract.wave("Another message!");
  await waveTxn2.wait();

  const allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
}

main()
  .then(() => {
    process.exit(0);
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
