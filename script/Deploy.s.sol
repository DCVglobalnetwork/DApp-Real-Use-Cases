// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Timelock} from "../src/Timelock.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract DeployContracts is Script {
    function run() external {
        // Set the lock duration to 1 day (in seconds)
        uint256 lockDuration = 60 * 60 * 24; // 1 day

        // Start broadcasting transactions
        vm.startBroadcast();

        // Deploy the Timelock contract with the specified lock duration
        Timelock timelock = new Timelock(lockDuration);

        // Deploy the SimpleStorage contract with the address of the Timelock contract
        SimpleStorage simpleStorage = new SimpleStorage(address(timelock));

        // Log the addresses of the deployed contracts
        console.log("Timelock deployed at:", address(timelock));
        console.log("SimpleStorage deployed at:", address(simpleStorage));

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
