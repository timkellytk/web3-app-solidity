import { ethers } from "hardhat";

async function main() {
  const waveContractFactory = await ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();
  console.log("Contract addy:", waveContract.address);

  const contractBalance = await ethers.provider.getBalance(
    waveContract.address
  );
  console.log("Contract balance: ", ethers.utils.formatEther(contractBalance));

  const waveTxn = await waveContract.wave("A message!");
  await waveTxn.wait();
  const waveTxn2 = await waveContract.wave("A message2!");
  await waveTxn2.wait();

  const updatedContractBalance = await ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance: ",
    ethers.utils.formatEther(updatedContractBalance)
  );

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
