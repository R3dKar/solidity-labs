// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_11 {
    address public owner;
    uint public targetAmount;
    
    enum State { Active, Paused, Closed }
    State public state;

    mapping(address => uint) public balances;
    uint public totalUserDeposits;

    modifier onlyOwner() {
        require(owner == msg.sender, "Not the owner");
        _;
    }

    modifier whenActiveOrPaused() {
        require(state != State.Closed, "Contract is closed");
        _;
    }

    modifier whenActive() {
        require(state == State.Active, "Contract is not active");
        _;
    }

    modifier whenClosed() {
        require(state == State.Closed, "Contract is not closed");
        _;
    }

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event StateChanged(State newState);

    constructor(uint _targetAmount) {
        require(_targetAmount > 0, "Target amount should be > 0");
        owner = msg.sender;
        targetAmount = _targetAmount;
        state = State.Active;
    }

    function deposit() external payable whenActive {
        require(msg.value > 0, "Deposit must be greater than 0");

        balances[msg.sender] += msg.value;
        totalUserDeposits += msg.value;

        emit Deposited(msg.sender, msg.value);

        if (totalUserDeposits >= targetAmount) {
            state = State.Closed;
            emit StateChanged(state);
        }
    }

    function withdraw() external whenActiveOrPaused {
        require(state == State.Paused, "Fund withdraw available only if paused");

        uint amount = balances[msg.sender];
        require(amount > 0, "No funds to withdraw");

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");

        balances[msg.sender] = 0;
        totalUserDeposits -= amount;

        emit Withdrawn(msg.sender, amount);
    }

    function ownerWithdrawAll() external onlyOwner whenClosed {
        uint amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");

        (bool success,) = owner.call{value: amount}("");
        require(success, "Withdrawal failed");

        totalUserDeposits = 0;
        
        emit Withdrawn(owner, amount);
    }

    function pause() external onlyOwner whenActiveOrPaused {
        require(state == State.Active, "Contract paused");
        state = State.Paused;
        emit StateChanged(state);
    }

    function resume() external onlyOwner whenActiveOrPaused {
        require(state == State.Paused, "Contract is not paused");
        state = State.Active;
        emit StateChanged(state);
    }

    function getState() external view returns (string memory) {
        if (state == State.Active) return "Active";
        if (state == State.Paused) return "Paused";
        if (state == State.Closed) return "Closed";
        return "";
    }
}