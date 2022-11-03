// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Funding {
    uint256 public totalBalance;
    address payable owner;

    event Received(address, uint256);
    event Sent(address, uint256);

    constructor() {
        totalBalance = 0;
    }

    receive() external payable {
        totalBalance += msg.value;
        emit Received(msg.sender, msg.value);
    }

    function sendFund(address payable user, uint256 amount) external payable {
        require(user != msg.sender, "cann't send funds to self");
        (bool sent, bytes memory data) = user.call{
            value: msg.value,
            gas: 20001
        }("");
        require(sent, "failed to send");
        emit Sent(user, msg.value);
    }
}
