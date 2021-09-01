// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity >=0.6.11;

import { Ownable } from "../../../modules/openzeppelin-contracts/contracts/access/Ownable.sol";

import { IMplRewards } from "../../interfaces/IMplRewards.sol";

contract Owner {

    /************************/
    /*** Direct Functions ***/
    /************************/

    function mplRewards_notifyRewardAmount(address mplRewards, uint256 amount) external {
        IMplRewards(mplRewards).notifyRewardAmount(amount);
    }

    function mplRewards_updatePeriodFinish(address mplRewards, uint256 periodFinish) external {
        IMplRewards(mplRewards).updatePeriodFinish(periodFinish);
    }

    function mplRewards_recoverERC20(address mplRewards, address tokenAddress, uint256 amount) external {
        IMplRewards(mplRewards).recoverERC20(tokenAddress, amount);
    }

    function mplRewards_setRewardsDuration(address mplRewards, uint256 duration) external {
        IMplRewards(mplRewards).setRewardsDuration(duration);
    }

    function mplRewards_setPaused(address mplRewards, bool paused) external {
        IMplRewards(mplRewards).setPaused(paused);
    }

    function mplRewards_renounceOwnership(address mplRewards) external {
        Ownable(mplRewards).renounceOwnership(); 
    }

    function mplRewards_transferOwnership(address mplRewards, address newOwner) external {
        Ownable(mplRewards).transferOwnership(newOwner); 
    }

    /*********************/
    /*** Try Functions ***/
    /*********************/

    function try_mplRewards_notifyRewardAmount(address mplRewards, uint256 amount) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.notifyRewardAmount.selector, amount));
    }

    function try_mplRewards_updatePeriodFinish(address mplRewards, uint256 periodFinish) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.updatePeriodFinish.selector, periodFinish));
    }

    function try_mplRewards_recoverERC20(address mplRewards, address tokenAddress, uint256 amount) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.recoverERC20.selector, tokenAddress, amount));
    }

    function try_mplRewards_setRewardsDuration(address mplRewards, uint256 duration) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.setRewardsDuration.selector, duration));
    }

    function try_mplRewards_setPaused(address mplRewards, bool paused) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.setPaused.selector, paused));
    }

    function try_mplRewards_renounceOwnership(address mplRewards) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(Ownable.renounceOwnership.selector));
    }

    function try_mplRewards_transferOwnership(address mplRewards, address newOwner) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(Ownable.transferOwnership.selector, newOwner));
    }

}
