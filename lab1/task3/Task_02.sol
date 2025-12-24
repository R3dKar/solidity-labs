// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_02 {
    uint[] public dynamicArray; // Динамический массив
    uint[5] public fixedArray;   // Фиксированный массив из 5 элементов

    function addToDynamicArray(uint _value) external {
        dynamicArray.push(_value); // Добавление элемента в динамический массив
    }

    function sumArray() external view returns (uint) {
        uint result = 0;
        for (uint i = 0; i < dynamicArray.length; i++)
            result += dynamicArray[i];
        return result;
    }
}
