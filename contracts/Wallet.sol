// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//console.sol is utility smartcontract which is created by harrdhat, this console log will work only whne u r running test => this only works in hardhat
import "hardhat/console.sol";

contract MultiSignerWallet {
    //store array of address
    address[] public owners;
    uint256 threshold; //if there is 5 owners if atleaset 3 of them accept then it should sign

    struct Transfer {
        uint256 id;
        uint256 amount;
        address payable to; //if we r transfering smone we have to make payable
        uint256 approvals;
        bool sent;
    }

    Transfer[] public transfers;

    //mapping who has approved
    // {address: {
    //     uint: bool
    // }}
    //this is how it works
    mapping(address => mapping(uint256 => bool)) public approvals;

    constructor(address[] memory _owners, uint256 _threshold) {
        // it should be decided that how many owner address and threshhold.It cant be change later if they want to change then owners have to decide
        owners = _owners;
        threshold = _threshold;
    }

    function getOwners() external view returns (address[] memory) {
        return owners;
    }

    function createTransfer(uint256 amount, address payable to) external {
        transfers.push(Transfer(transfers.length, amount, to, 0, false));
    }

    function getTransfers() external view returns (Transfer[] memory) {
        return transfers;
    }

    function approveTransfer(uint256 id) external {
        require(transfers[id].sent == false, "tranfer has already been sent");
        // we r checking sender address have a id it returns bool
        require(
            approvals[msg.sender][id] == false,
            "cann't approve tranfer again"
        );

        //now allowing the sender to get approved
        approvals[msg.sender][id] == true;
        transfers[id].approvals++;

        //checking threashhold and transfering
        if (transfers[id].approvals >= threshold) {
            transfers[id].sent = true;
            address payable to = transfers[id].to;
            uint256 amount = transfers[id].amount;
            to.transfer(amount);
        }
    }

    // this is function where we can directly pass the value to the contract, no need to pass any variable
    function deposite() external payable {}
}
