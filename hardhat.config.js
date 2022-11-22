require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

require("dotenv").config();
const { API_URL, PRIVATE_KEY } = process.env;
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
module.exports = {
  defaultNetwork: "goerli",
  networks: {
    hardhat: {
      //  allowUnlimitedContractSize: true,
      //  gasPrice:   28000000000, //875000000,
      //  gas: 6000000,
      //ygasPrice: 1662963891113581,
    },
    rinkeby: {
      url: "https://rinkeby.infura.io/v3/802287e8973648e2b7f80dc3b438396a",
      accounts: [PRIVATE_KEY],
      gasPrice: 2310000,
      gas: 6000000,
    },
    goerli: {
      url: 'https://goerli.infura.io/v3/093b4fa91bff4c14b88d04dccdb94bee',
      accounts: [PRIVATE_KEY],
    },

    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/RGYs6b1Ynxzx_NUlIN8BU5yrV50oee13",
      accounts: [PRIVATE_KEY],
      gasPrice: 250000,
    },
  },
  solidity: {
    version: "0.8.13",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  mocha: {
    timeout: 40000,
  },
  etherscan: {
    apiKey: "ASRHUYE4WCM62YKSAKWBB52YTN7PY8H9I1",
  },
  // etherscan: {
  //   apiKey: {
  //     polygonMumbai: 'U7YM1CMSDN917MKWGUJCY178JUS21YZWKC'
  //   }
  // }
};

// // for localhost

// require("@nomiclabs/hardhat-waffle");

// // This is a sample Hardhat task. To learn how to create your own go to
// // https://hardhat.org/guides/create-task.html
// task("accounts", "Prints the list of accounts", async () => {
//   const accounts = await ethers.getSigners();

//   for (const account of accounts) {
//     console.log(account.address);
//   }
// });

// // You need to export an object to set up your config
// // Go to https://hardhat.org/config/ to learn more

// /**
//  * @type import('hardhat/config').HardhatUserConfig
//  */
// module.exports = {
//   solidity: "0.8.4",
// };
