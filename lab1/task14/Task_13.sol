// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleUsage {
    // Пример использования assert
    function assertExample(uint256 _value) public pure {
        assert(_value != 0);
    }


    // Пример использования revert
    function revertExample(bool _condition) public pure {
        if (!_condition) {
            revert("Invalid condition");
        }
    }


    // Пример использования if-else
    function ifElseExample(uint256 _value) public pure returns (string memory) {
        if (_value > 10) {
            return "Value is greater than 10";
        } else {
            return "Value is 10 or less";
        }
    }


    // Пример использования else if
    function elseIfExample(uint256 _value) public pure returns (string memory) {
        if (_value > 10) {
            return "Value is greater than 10";
        } else if (_value == 10) {
            return "Value is exactly 10";
        } else {
            return "Value is less than 10";
        }
    }


    // Пример использования тернарного оператора
    function ternaryExample(uint256 _value) public pure returns (string memory) {
        if (_value > 10) {
            return "Value is greater than 10";
        } else {
            return "Value is 10 or less";
        }
    }
}
