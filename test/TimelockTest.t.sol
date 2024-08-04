// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Timelock} from "../src/Timelock.sol";

contract TimelockTest is Test {
    // Instance of the Timelock contract
    Timelock timelock;

    // Lock duration of 1 day (in seconds)
    uint256 lockDuration = 60 * 60 * 24; // 1 day

    // Set up the test environment
    function setUp() public {
        // Deploy the Timelock contract with a lock duration of 1 day
        timelock = new Timelock(lockDuration);
    }

    // Test to check if the initial lock state is active
    function testInitialLock() public view {
        // Assert that the timelock is initially locked
        assertTrue(timelock.isLocked());
    }

    // Test to check if extending the lock works correctly
    function testExtendLock() public {
        // Store the initial unlock time
        uint256 initialUnlockTime = timelock.unlockTime();

        // Extend the lock by 1 hour
        timelock.extendLock(60 * 60); // Extend by 1 hour

        // Assert that the new unlock time is equal to the initial unlock time plus 1 hour
        assertEq(timelock.unlockTime(), initialUnlockTime + 60 * 60);
    }
}
