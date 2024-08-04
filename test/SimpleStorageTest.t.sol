// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Timelock} from "../src/Timelock.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    // Declare instances of the Timelock and SimpleStorage contracts
    Timelock timelock;
    SimpleStorage simpleStorage;
    // Lock duration of 1 day (in seconds)
    uint256 lockDuration = 60 * 60 * 24; // 1 day

    function setUp() public {
        // Deploy the Timelock contract with a lock duration of 1 day
        timelock = new Timelock(lockDuration);
        // Deploy the SimpleStorage contract with the address of the Timelock contract
        simpleStorage = new SimpleStorage(address(timelock));
    }

    function testFailSetNumberWhileLocked() public {
        // Attempt to set the number while the Timelock is still active
        // Expect the transaction to revert with the message "Timelock is still active"
        vm.expectRevert("Timelock is still active");
        simpleStorage.setNewNumber(42);
    }
}
