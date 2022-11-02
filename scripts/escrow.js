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

  const [lawyer, payer, payee] = await hre.ethers.getSigners();

  const Escrow = await hre.ethers.getContractFactory("Escrow");
  const escrow = await Escrow.deploy(
    payer.address,
    payee.address,
    10000000 //this will take in wei so we have converted in to one ETH
  );
  await escrow.deployed();

  await escrow.connect(payer).deposit({ value: 10000000 });

  await escrow.connect(payee).submitWork();

  const BalanceOfPayee1 = await hre.ethers.provider.getBalance(payee.address);

  await escrow.connect(lawyer).release();

  const contractBalance = await escrow.balanceOf();

  const BalanceOfPayee = await hre.ethers.provider.getBalance(payee.address);

  console.log(
    "escrow deployeed to",
    escrow.address,
    BalanceOfPayee1,
    contractBalance,
    BalanceOfPayee
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
