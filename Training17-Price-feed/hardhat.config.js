require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",

  defaultNetwork: "arbitrum-sepolia",
  networks: {
    "arbitrum-sepolia": {
      url: "https://sepolia-rollup.arbitrum.io/rpc",
      chainId: 421614,
      accounts: ['0x955e20c92051f9cd00b51ddc08b23fde98106ee88b625bf39245248ece67b5b8']
    }
  }
};
