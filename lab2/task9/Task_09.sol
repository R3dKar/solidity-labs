// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_09 {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier only_owner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    struct User {
        uint id;
        string name;
    }

    mapping(uint => User) private users;
    mapping(uint => bool) private user_exist;
    uint private last_id;

    event UserAdded(uint indexed user_id, string message);
    event UserRemoved(uint indexed user_id, string message);

    function addUser(string calldata name) external only_owner {
        last_id++;
        users[last_id] = User(last_id, name);
        user_exist[last_id] = true;

        emit UserAdded(last_id, "User added successfully");
    }

    function removeUser(uint user_id) external only_owner {
        require(user_exist[user_id], "User does not exist");

        users[user_id] = User(0, "");
        user_exist[user_id] = false;

        emit UserRemoved(user_id, "User removed successfully");
    }

    function getUser(uint user_id) external view returns (User memory) {
        require(user_exist[user_id], "User does not exist");
        return users[user_id];
    }
}