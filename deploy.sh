#!/bin/bash

# Step 1: Navigate to your project directory
cd /root/mydexapp

# Step 2: Initialize a new Truffle project
truffle init

# Step 3: Create the smart contract file
cat <<EOF > contracts/blacktea024.sol
pragma solidity ^0.8.0;

contract blacktea024 {
    // Your contract code here
}
EOF

# Step 4: Write the migration script
cat <<EOF > migrations/2_deploy_blacktea024.js
const BlackTea024 = artifacts.require("blacktea024");

module.exports = function(deployer) {
  deployer.deploy(BlackTea024);
};
EOF

# Step 5: Configure Truffle for the Arbitrum network
cat <<EOF >> truffle-config.js
const HDWalletProvider = require('@truffle/hdwallet-provider');

const mnemonic = "educate sword party ring peanut caught auction blood pumpkin gospel humble clarify"; // Add your mnemonic
const arbitrumUrl = "https://rinkeby.arbitrum.io/rpc"; // Arbitrum Rinkeby testnet

module.exports = {
  networks: {
    arbitrumTestnet: {
      provider: () => new HDWalletProvider(mnemonic, arbitrumUrl),
      network_id: "*",
      gas: 8000000, // Arbitrum testnet gas limit
      gasPrice: 0,
      confirmations: 1,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },
  compilers: {
    solc: {
      version: "0.8.7", // Use the same Solidity version as your contract
    }
  },
};
EOF

# Step 6: Run migration to deploy the contract
truffle migrate --network arbitrumTestnet

