// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Oracle {
    address public owner;

    mapping(address => uint256) public assetPrice;

    uint256 public decimals;

    constructor(address _owner, uint256 _decimals) {
        owner = _owner;
        decimals = _decimals;
    }

    function getPrice(address _asset) external view returns (uint256) {
        return assetPrice[_asset];
    }

    function setPrice(address _asset, uint256 _price) external returns (bool) {
        require(msg.sender == owner, "Only owner is allowed");
        assetPrice[_asset] = _price;
        return true;
    }
}
