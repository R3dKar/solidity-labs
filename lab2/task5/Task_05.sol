// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_05 {
    int16[] private temperatures;

    function addTemperatures(int16[] calldata new_temperatures) external {
        for (uint i = 0; i < new_temperatures.length; i++)
            temperatures.push(new_temperatures[i]);
    }

    function convertToFahrenheit(int16 temperature) public pure returns (int16) {
        return temperature * 9 / 5 + 32;
    }

    function getTemperaturesCelsius() external view returns (int16[] memory) {
        return temperatures;
    }

    function getTemperaturesFahrenheit() external view returns (int16[] memory) {
        int16[] memory temperatures_fahrenheit = new int16[](temperatures.length);

        for (uint i = 0; i < temperatures.length; i++)
            temperatures_fahrenheit[i] = convertToFahrenheit(temperatures[i]);

        return temperatures_fahrenheit;
    }
}
