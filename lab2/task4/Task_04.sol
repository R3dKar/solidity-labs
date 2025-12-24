// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_04 {
    function generateFibo(uint n) external pure returns (uint) {
        uint a = 0;
        uint b = 1;

        do {
            uint temp = a + b;
            a = b;
            b = temp;
        } 
        while (b <= n);

        return b;
    }
}
