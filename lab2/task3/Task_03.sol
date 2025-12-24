// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_03 {
    function generateFactorial(uint n) external pure returns (uint) {
        uint result = 1;
        
        uint i = 2;
        while (i <= n)
            result *= i++;

        return result;
    }
}
