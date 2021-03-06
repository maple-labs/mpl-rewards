// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { DSTest } from "../../modules/ds-test/src/test.sol";

import { MplRewards, MplRewardsFactory } from "../MplRewardsFactory.sol";

import { Governor } from "./accounts/Governor.sol";

contract MapleGlobalsMock {

    address public governor;

    constructor(address _governor) public {
        governor = _governor;
    }

}

contract MplRewardsFactoryTest is DSTest {

    function test_constructor() external {
        MplRewardsFactory rewardsFactoryContract = new MplRewardsFactory(address(1));

        assertEq(address(rewardsFactoryContract.globals()), address(1));
    }

    function test_setGlobals() external {
        Governor          governor               = new Governor();
        Governor          notGovernor            = new Governor();
        MapleGlobalsMock  mapleGlobalsContract   = new MapleGlobalsMock(address(governor));
        MplRewardsFactory rewardsFactoryContract = new MplRewardsFactory(address(mapleGlobalsContract));

        assertTrue(!notGovernor.try_mplRewardsFactory_setGlobals(address(rewardsFactoryContract), address(1)));
        assertTrue(    governor.try_mplRewardsFactory_setGlobals(address(rewardsFactoryContract), address(1)));
    }

    function test_createMplRewards() external {
        Governor          governor               = new Governor();
        Governor          notGovernor            = new Governor();
        MapleGlobalsMock  mapleGlobalsContract   = new MapleGlobalsMock(address(governor));
        MplRewardsFactory rewardsFactoryContract = new MplRewardsFactory(address(mapleGlobalsContract));
        
        assertTrue(!notGovernor.try_mplRewardsFactory_createMplRewards(address(rewardsFactoryContract), address(1), address(2)));

        address rewardsContract = governor.mplRewardsFactory_createMplRewards(address(rewardsFactoryContract), address(1), address(2));

        assertTrue(rewardsFactoryContract.isMplRewards(rewardsContract));

        assertEq(address(MplRewards(rewardsContract).rewardsToken()),    address(1));
        assertEq(address(MplRewards(rewardsContract).stakingToken()),    address(2));
        assertEq(uint256(MplRewards(rewardsContract).rewardsDuration()), 7 days);
        assertEq(address(MplRewards(rewardsContract).owner()),           address(governor));
    }

}
