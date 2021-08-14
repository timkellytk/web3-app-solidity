import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the acount: ", deployer.address);
  console.log("Account balance: ", (await deployer.getBalance()).toString());

  const Token = await ethers.getContractFactory("WavePortal");
  const tokenDeployed = await Token.deploy();

  console.log("WavePortal address:", tokenDeployed.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
