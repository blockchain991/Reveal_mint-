const { ethers, providers } = require("ethers");
require("dotenv").config();

const PUBLIC_KEY = process.env.PUBLIC_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

const contracts = require("../artifacts/contracts/Mint.sol/MintNFT.json"); // for Hardhat

const contractAddress = "0xfb24f823401a758b80c11844e7b3287473ab1252";

// Ethers.js
// const url =
//   "https://eth-rinkeby.alchemyapi.io/v2/uAHNpcU3cQBCRW3gbEV6S-7KM6N4olc2";
// const customHttpProvider = new ethers.providers.JsonRpcProvider(url);

async function main() {

  const signer = new ethers.Wallet(
    PRIVATE_KEY,
    providers.getDefaultProvider("rinkeby")
  );

  const contract = new ethers.Contract(contractAddress, contracts.abi, signer);

 // var staticUri = "ipfs://QmRMcd9hyogckzRNtyqSvFBgzLW1WBTprWw2hQZ1NThxSg";
  var meta10 = "ipfs://Qmb46VsELhcvRsPxbRPuLvUTCKs6k2U97aWKACdqVo8iTt/1";
  var array = [];

  var address = "0x317ac0d437EaD0Ee48F807819D1a6ac7bB8AAc7E";


  for (let i = 0; i < 10; i++) {
    array.push(i);
  }

  for (let i = 0; i < 10; i++) {
    console.log(array[i]);
  }



  // let res = await contract.bulkMint(address, array);
  // res = await res.wait().catch((error)=>{
  //   console.log(error)
  // });


  let res = await contract.mint(array);
  res = await res.wait().catch((error)=>{
    console.log(error)
  });

  // clone mint
  // for (let i = 0; i < 1; i++) {
  //   let res = await contract.Bmint(address, staticUri);
  //   res = await res.wait();
  // }

}

main();
