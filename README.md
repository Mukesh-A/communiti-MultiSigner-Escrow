# Solidity Project
## MultiSigner
A wallet which need approval of multiplle people to transfer fund.No one entity can operate this wallet.Number of approver should be defined in the form of threshold.We have various type of require query in different function.

ApproveTransfer() was a complicated function while writing this smart contract,understood it when deployed the code repetedly.

## Fund Transfer Contract
A contract which can transfer the ether from one address to another.
require functions to check the address is valid || !valid, then look for the fund transfer has required amount to send the receiver.

## Escrow Contract
lets take an example to understand escrow contract. suppose person A want to send ether to B for the issue of X product.when the smart contract starts A's ether get locked by a middle man lawyer(in the contract) then when the Product X reach to Person A then the Ethers which is locked in lawyers will be released to Person B 
Difficulty part in this contract was to understand the working of Lawyer(Locking of ethers).
