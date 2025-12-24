// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_06 {
    mapping(uint => string) private colors;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier rainbowIndex(uint index) {
        require(1 <= index && index <= 7, "Rainbow color must be in range from 1 to 7");
        _;
    }

    function addColor(uint index, string calldata color) public rainbowIndex(index) {
        colors[index] = color;
    }

    function getColor(uint index) public rainbowIndex(index) view returns (string memory) {
        return colors[index];
    }

    function colorExists(uint index) public rainbowIndex(index) view returns (bool) {
        return bytes(colors[index]).length > 0;
    }

    function removeColor(uint index) public rainbowIndex(index) onlyOwner {
        colors[index] = "";
    }

    function getAllColors() public view returns (string[] memory) {
        string[] memory colors_array = new string[](7);
        uint real_length = 0;

        for (uint i = 1; i <= 7; i++) {
            if (!colorExists(i)) continue;

            colors_array[real_length++] = colors[i];
        }

        string[] memory result = new string[](real_length);

        for (uint i = 0; i < result.length; i++)
            result[i] = colors_array[i];

        return result;
    }
}
