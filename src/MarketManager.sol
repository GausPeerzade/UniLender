// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract MarketManager {
    address public owner;
    

    constructor(address _owner) {
        owner = _owner;
    }


    function deposit() external returns(bool){}

    function withdraw() external returns(bool) {}

    function borrowHere() external returns(bool){}

    function borrowCrosschain(uint256 _chainID) external returns(bool , uint256){}

    function getCollateral(address _user) public view returns(uint256){}

    function getBorrow(address _user) public view returns(uint256){}

    function assetToUsd(uint256 _amount) public view returns(uint256){}

    function getHealthFactor(address _user) public view returns(uint256){}

}