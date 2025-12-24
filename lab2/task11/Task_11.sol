// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_11 {
    address public owner;

    enum Status { Active, Paused, Closed }
    Status public status;

    constructor(uint _targetAmount) {
        status = Status.Active;
        targetAmount = _targetAmount;
        owner = msg.sender;
    }

    uint public totalUserDeposits;
    uint public targetAmount;

    mapping(address => uint) public userDeposits;

    modifier onlyOwner() {
        require(owner == msg.sender, "Not the owner");
        _;
    }

    modifier whenClosed() {
        require(status == Status.Closed, "Contract is not closed");
        _;
    }

    modifier whenActive() {
        require(status == Status.Active, "Contract is not active");
        _;
    }

    modifier whenNotClosed() {
        require(status != Status.Closed, "Contract is closed");
        _;
    }

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event Closed(uint totalAmount);

    function deposit() external payable whenActive {
        require(msg.value > 0, "Deposit must be greater than 0");

        userDeposits[msg.sender] += msg.value;
        totalUserDeposits += msg.value;

        emit Deposited(msg.sender, msg.value);

        if (totalUserDeposits >= targetAmount) {
            status = Status.Closed;

            emit Closed(totalUserDeposits);
        }
    }

    function withdraw() external whenNotClosed {
        require(userDeposits[msg.sender] > 0, "No funds to withdraw");

        uint amount = userDeposits[msg.sender];

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");

        userDeposits[msg.sender] = 0;
        totalUserDeposits -= amount;

        emit Withdrawn(msg.sender, amount);
    }

    function withdrawAll() external onlyOwner whenClosed {
        require(totalUserDeposits > 0, "No funds to withdraw");

        uint amount = totalUserDeposits;

        (bool success,) = owner.call{value: amount}("");
        require(success, "Withdrawal failed");

        totalUserDeposits = 0;
        
        emit Withdrawn(owner, amount);
    }

    function pause() external onlyOwner whenNotClosed {
        status = Status.Paused;
    }

    function unpause() external onlyOwner whenNotClosed {
        status = Status.Active;
    }
}