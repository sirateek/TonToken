const HDWalletProvider = require("@truffle/hdwallet-provider");
const fs = require("fs");

// Please Create the `secret.json` that contain the data structure like this
// {
//   "privateKey": {
//     "ropsten": "",
//     "mainNet": ""
//   },
//   "infuraProjectId": ""
// }
const secretFile = JSON.parse(fs.readFileSync("secret.json"));

module.exports = {
  networks: {
    ropsten: {
      provider: () =>
        new HDWalletProvider(
          secretFile.privateKey.ropsten,
          "https://ropsten.infura.io/v3/" + secretFile.infuraProjectId
        ),
      network_id: 3, // Ropsten's id
      gas: 5500000, // Ropsten has a lower block limit than mainnet
      confirmations: 2, // # of confs to wait between deployments. (default: 0)
      timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true, // Skip dry run before migrations? (default: false for public nets )
    },
    mainnet: {
      provider: () =>
        new HDWalletProvider(
          secretFile.privateKey.mainNet,
          "https://mainnet.infura.io/v3/" + secretFile.infuraProjectId
        ),
      network_id: 1,
      gas: 100000,
      gasPrice: 6900000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
    },
  },

  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.4", // Fetch exact version from solc-bin (default: truffle's version)
      docker: false, // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {
        // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: false,
          runs: 200,
        },
        evmVersion: "byzantium",
      },
    },
  },

  db: {
    enabled: false,
  },
};
