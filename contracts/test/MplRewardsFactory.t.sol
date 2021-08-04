// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { DSTest } from "../../modules/ds-test/src/test.sol";

import { MplRewards, MplRewardsFactory } from "../MplRewardsFactory.sol";

import { MplRewardsFactoryGovernor } from "./accounts/MplRewardsFactoryGovernor.sol";

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
        MplRewardsFactoryGovernor governor       = new MplRewardsFactoryGovernor();
        MplRewardsFactoryGovernor notGovernor    = new MplRewardsFactoryGovernor();
        MapleGlobalsMock mapleGlobalsContract    = new MapleGlobalsMock(address(governor));
        MplRewardsFactory rewardsFactoryContract = new MplRewardsFactory(address(mapleGlobalsContract));

        assertTrue(!notGovernor.try_mplRewards_setGlobals(address(rewardsFactoryContract), address(1)));
        assertTrue(    governor.try_mplRewards_setGlobals(address(rewardsFactoryContract), address(1)));
    }

    function test_createMplRewards() external {
        MplRewardsFactoryGovernor governor       = new MplRewardsFactoryGovernor();
        MplRewardsFactoryGovernor notGovernor    = new MplRewardsFactoryGovernor();
        MapleGlobalsMock mapleGlobalsContract    = new MapleGlobalsMock(address(governor));
        MplRewardsFactory rewardsFactoryContract = new MplRewardsFactory(address(mapleGlobalsContract));
        
        assertTrue(!notGovernor.try_mplRewards_createMplRewards(address(rewardsFactoryContract), address(1), address(2)));

        address rewardsContract = governor.mplRewards_createMplRewards(address(rewardsFactoryContract), address(1), address(2));

        assertTrue(rewardsFactoryContract.isMplRewards(rewardsContract));

        assertEq(address(MplRewards(rewardsContract).rewardsToken()),    address(1));
        assertEq(address(MplRewards(rewardsContract).stakingToken()),    address(2));
        assertEq(uint256(MplRewards(rewardsContract).rewardsDuration()), 7 days);
        assertEq(address(MplRewards(rewardsContract).owner()),           address(governor));
    }

}
