// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Timelock {
    // Timestamp when the funds can be unlocked
    uint256 public unlockTime;

    // Owner of the contract
    address private immutable owner;

    // Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Constructor to set the owner and the unlock time
    constructor(uint256 _lockDuration) {
        owner = msg.sender;
        unlockTime = block.timestamp + _lockDuration;
    }

    // Function to extend the lock duration
    function extendLock(uint256 _additionalTime) public onlyOwner {
        unlockTime += _additionalTime;
    }

    // Function to withdraw funds, only callable by the owner
    // This function only checks if the funds are unlocked
    function withdraw() public view onlyOwner {
        require(block.timestamp >= unlockTime, "Funds are still locked");
        // Logic to withdraw funds goes here
    }

    // Function to check if the funds are still locked
    function isLocked() public view returns (bool) {
        return block.timestamp < unlockTime;
    }
}
