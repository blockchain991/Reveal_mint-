// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
// const hre = require("hardhat");

// async function main() {
//   const currentTimestampInSeconds = Math.round(Date.now() / 1000);
//   const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
//   const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

//   const lockedAmount = hre.ethers.utils.parseEther("1");

//   const Lock = await hre.ethers.getContractFactory("Lock");
//   const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

//   await lock.deployed();

//   console.log("Lock with 1 ETH deployed to:", lock.address);
// }

// // We recommend this pattern to be able to use async/await everywhere
// // and properly handle errors.
// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });


const hre = require('hardhat')

async function main() {
  const [deployer] = await ethers.getSigners()

  console.log("Deployer's Account: ", deployer.address)

  const Token = await hre.ethers.getContractFactory('ObscuraNFT')
  const token = await Token.deploy("https://crimson-added-cephalopod-217.mypinata.cloud/ipfs/QmRrYVRDJvRruw94GR3L3p3c9Cw2MSCk7Taq5p5NvUPCTH/","https://crimson-added-cephalopod-217.mypinata.cloud/ipfs/QmNk2rc3tU7pQmJXvrtg7Fs8H75MqmCNoFc5speRmiGLSP",2)

  console.log('Token address:', token.address.toLowerCase())
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
