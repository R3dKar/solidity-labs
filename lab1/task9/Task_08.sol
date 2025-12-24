// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_08 {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Пример 2: Работа с динамическим массивом байтов
    // Функция возвращает длину массива
    function getDynamicByteArrayLength(bytes memory _data) public pure returns (uint256) {
        return _data.length;
    }

    function getDynamicByteArrayElement(bytes calldata _data, uint _index) public pure returns (bytes1) {
        require(_index < _data.length, "Invalid index");
        return data[_index];
    }
}
