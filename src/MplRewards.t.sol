pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./MplRewards.sol";

contract MplRewardsTest is DSTest {
    MplRewards rewards;

    function setUp() public {
        rewards = new MplRewards();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
