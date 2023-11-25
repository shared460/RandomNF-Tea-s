require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork:'hardhat',
  solidity: {
    compilers: [{version:'0.8.19'},{version: '0.8.20'},{version: '0.6.0'}],
  },
  // networks: {
  //   sepolia: {
  //     accounts: [process.env.PRIVATE_KEY],
  //     chainId: '11155111',
  //   },
  // },
};
