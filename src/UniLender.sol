// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract UniLender {
   address public owner;
   address public managerContract;
   

   constructor(address _owner){
    owner = _owner;
   }
}