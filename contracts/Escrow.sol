// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

//payer - has to send eth
//receiver - has to recive eth
//lawyer - has to sign the contract
//amount

contract Escrow {
    address public payer;
    address payable public payee;
    address public lawyer;
    uint256 public amount;

    bool workdone;

    constructor(
        address _payer,
        address payable _payee, // y we not added lawyer here because it is going to setup the contract i.e msg.sender
        uint256 _amount
    ) {
        payer = _payer;
        payee = _payee;
        lawyer = msg.sender;
        amount = _amount;
        workdone = false;
    }

    function deposit() public payable {
        require(msg.sender == payer, "sender must be payer");
        require(
            address(this).balance <= amount,
            "cant send more than escrow amount"
        );
    }

    function submitWork() external {
        require(msg.sender == payee, "sender must be payee");
        workdone = true;
    }

    function release() public {
        require(msg.sender == lawyer, "only lawyer can release the fund");
        require(
            address(this).balance == amount,
            "Cannot release funds : insufficient amount"
        );
        require(workdone == true, "work is not finished");
        payee.transfer(amount);
    }

    function balanceOf() public view returns (uint256) {
        return address(this).balance;
    }
}
