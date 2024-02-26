const hre = require("hardhat");



async function main() {
  // const MyContract = await ethers.getContractFactory("MyContract");
  const myContract = await hre.ethers.deployContract("PriceFeed", ['0x3765E718E01F4d8B2B50A12BB1B03cF858d500fE']);
  await myContract.waitForDeployment();

  console.log("MyContract deployed to:", myContract.target, await myContract.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
