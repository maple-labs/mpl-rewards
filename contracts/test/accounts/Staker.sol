// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity >=0.6.11;

import { ERC2258Account } from "../../../modules/custodial-ownership-token/contracts/test/accounts/ERC2258Account.sol";

import { IMplRewards } from "../../interfaces/IMplRewards.sol";

contract Staker is ERC2258Account {

    /************************/
    /*** Direct Functions ***/
    /************************/

    function mplRewards_stake(address mplRewards, uint256 amount) external {
        IMplRewards(mplRewards).stake(amount);
    }

    function mplRewards_withdraw(address mplRewards, uint256 amount) external {
        IMplRewards(mplRewards).withdraw(amount);
    }

    function mplRewards_getReward(address mplRewards) external {
        IMplRewards(mplRewards).getReward();
    }

    function mplRewards_exit(address mplRewards) external {
        IMplRewards(mplRewards).exit();
    }

    /*********************/
    /*** Try Functions ***/
    /*********************/

    function try_mplRewards_stake(address mplRewards, uint256 amount) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.stake.selector, amount));
    }

    function try_mplRewards_withdraw(address mplRewards, uint256 amount) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.withdraw.selector, amount));
    }

    function try_mplRewards_getReward(address mplRewards) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.getReward.selector));
    }

    function try_mplRewards_exit(address mplRewards) external returns (bool ok) {
        (ok,) = mplRewards.call(abi.encodeWithSelector(IMplRewards.exit.selector));
    }

}
