// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { IMapleGlobalsLike }  from "./interfaces/IMapleGlobalsLike.sol";
import { IMplRewardsFactory } from "./interfaces/IMplRewardsFactory.sol";

import { MplRewards } from "./MplRewards.sol";

/// @title MplRewardsFactory instantiates MplRewards contracts.
contract MplRewardsFactory is IMplRewardsFactory {

    address public override globals;

    mapping(address => bool) public override isMplRewards;  // True only if an MplRewards was created by this factory.

    constructor(address _globals) public {
        globals = _globals;
    }

    function setGlobals(address _globals) external override {
        require(msg.sender == IMapleGlobalsLike(globals).governor(), "RF:NOT_GOV");
        globals = _globals;
    }

    function createMplRewards(address rewardsToken, address stakingToken) external override returns (address mplRewards) {
        require(msg.sender == IMapleGlobalsLike(globals).governor(), "RF:NOT_GOV");
        mplRewards               = address(new MplRewards(rewardsToken, stakingToken, msg.sender));
        isMplRewards[mplRewards] = true;

        emit MplRewardsCreated(rewardsToken, stakingToken, mplRewards, msg.sender);
    }

}
