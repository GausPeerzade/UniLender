// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IERC20.sol";
import "./interfaces/IRouter.sol";
import "./interfaces/IEquitoReceiver.sol";
import "./interfaces/IOracle.sol";

struct userInfo {
    uint256 totalDeposited;
    uint256 totalBorrowed;
    uint256 lastBorrowed;
}

contract MarketManager {
    //protocol config
    address public owner;

    //cross chain config
    mapping(uint256 => bool) public validChainId;
    mapping(uint256 => string) public chainName;

    //core logic config
    address public depositToken;
    address public oracle;

    uint256 public depositRate; // deposit interest per second
    uint256 public depositRateDecimals; // decimals to avoide underflow/overflow issue

    uint256 public borrowRate; // borrow interst per second
    uint256 public borrowRateDecimals; // decimals to avoide underflow/overflow issue

    uint256 public minHF; // minimum health factor ie 1

    mapping(address => userInfo) public userData;

    // events

    event UserDeposit(address depositer, uint256 amount);
    event UserWithdraw(address user, uint256 amount);

    constructor(address _owner) {
        owner = _owner;
    }

    function deposit(uint256 _amount) external returns (bool) {
        require(_amount > 0, "Amount cannot be zero");
        IERC20(depositToken).transferFrom(msg.sender, address(this), _amount);
        userInfo storage user = userData[msg.sender];
        user.totalDeposited += _amount;
        emit UserDeposit(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external returns (bool) {
        userInfo storage user = userData[msg.sender];
        require(_amount <= user.totalDeposited, "Withdraw more than deposited");
        revertIfHealthFactorBroken(msg.sender);
        user.totalDeposited -= _amount;
        emit UserWithdraw(msg.sender, _amount);
    }

    function triggerBorrow(
        uint256 _chainId,
        uint256 _amount
    ) external returns (bool) {}

    function repayCrosschain(address _user, uint256 _amount) internal {}

    function borrowCrosschain(
        uint256 _chainID
    ) external returns (bool, uint256) {}

    function getCollateralValue(address _user) public view returns (uint256) {}

    function getBorrowValue(address _user) public view returns (uint256) {}

    function assetToUsd(uint256 _amount) public view returns (uint256) {
        uint256 assetPrice = IOracle(oracle).getPrice(depositToken);

        return (_amount * assetPrice) / 1e18; //adjusting the decimals
    }

    function usdToAsset(uint256 _amount) public view returns (uint256) {
        uint256 assetPrice = IOracle(oracle).getPrice(depositToken);
        return (_amount * 1e18) / assetPrice; //adjusting the decimals
    }

    function getHealthFactor(address _user) public view returns (uint256) {}

    function revertIfHealthFactorBroken(
        address _user
    ) internal view returns (uint256) {}
}
