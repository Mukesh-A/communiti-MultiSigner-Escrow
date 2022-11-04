# Solidity Project
## MultiSigner
A wallet which need approval of multiplle people to transfer fund.No one entity can operate this wallet.Number of approver should be defined in the form of threshold.We have various type of require query in different function.

ApproveTransfer() was a complicated function while writing this smart contract,understood it when deployed the code repetedly.

## Fund Transfer Contract
A contract which can transfer the ether from one address to another.
require functions where to check the address is valid || !valid, then look for the fund transfer has required amount to send the receiver.
