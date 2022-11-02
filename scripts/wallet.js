// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  //   const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  //   const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  //   const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  //   const lockedAmount = hre.ethers.utils.parseEther("1");

  const [owner1, owner2, owner3, recipient1] = await hre.ethers.getSigners();
  const threshold = 3;

  const MultiSignerWallet = await hre.ethers.getContractFactory(
    "MultiSignerWallet"
  );
  const wallet = await MultiSignerWallet.deploy(
    [owner1.address, owner2.address, owner3.address],
    threshold
  );

  await wallet.deployed();
  const owners = await wallet.getOwners();
  console.log("wallet deployed to", owners);

  //getting the owners data
  const transfer = await wallet.createTransfer(1, recipient1.address);
  await transfer.wait();

  const transfers = await wallet.getTransfers();

  const approver1 = await wallet.connect(owner1).approveTransfer(0);
  await approver1.wait();

  const approver2 = await wallet.connect(owner2).approveTransfer(0);
  await approver2.wait();

  const transfers2 = await wallet.getTransfers();
  console.log(transfers, transfers2);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
