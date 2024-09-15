// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IOracle {
    function getPrice(address _asset) external view returns (uint256);
}
