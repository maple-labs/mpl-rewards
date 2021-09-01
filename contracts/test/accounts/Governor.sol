// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity >=0.6.11;

import { IMplRewardsFactory } from "../../interfaces/IMplRewardsFactory.sol";

contract Governor {

    /************************/
    /*** Direct Functions ***/
    /************************/

    function mplRewardsFactory_setGlobals(address factory, address newGlobals) external {
        IMplRewardsFactory(factory).setGlobals(newGlobals);
    }

    function mplRewardsFactory_createMplRewards(address factory, address rewardsToken, address stakingToken) external returns (address mplRewards) {
        return IMplRewardsFactory(factory).createMplRewards(rewardsToken, stakingToken);
    }

    /*********************/
    /*** Try Functions ***/
    /*********************/

    function try_mplRewardsFactory_setGlobals(address factory, address newGlobals) external returns (bool ok) {
        (ok,) = factory.call(abi.encodeWithSelector(IMplRewardsFactory.setGlobals.selector, newGlobals));
    }

    function try_mplRewardsFactory_createMplRewards(address factory, address rewardsToken, address stakingToken) external returns (bool ok) {
        (ok,) = factory.call(abi.encodeWithSelector(IMplRewardsFactory.createMplRewards.selector, rewardsToken, stakingToken));
    }

}
