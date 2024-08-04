// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {Timelock} from "./Timelock.sol";

contract SimpleStorage {
    // State variable to store a number
    uint256 private storedNumber;

    // Instance of the Timelock contract
    Timelock private timelock;

    // Event to emit when the number is updated
    event UpdatedNumber(uint256 oldNumber, uint256 newNumber);

    // Owner of the contract
    address private owner;

    // Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Constructor to set the owner and the Timelock contract address
    constructor(address _timelockAddress) {
        owner = msg.sender;
        timelock = Timelock(_timelockAddress);
    }

    // Function to set a new number, only callable by the owner
    function setNewNumber(uint256 _number) public onlyOwner {
        // Ensure the timelock is not active
        require(!timelock.isLocked(), "Timelock is still active");

        // Store the old number
        uint256 oldNumber = storedNumber;

        // Update the stored number
        storedNumber = _number;

        // Emit the event to notify that the number has been updated
        emit UpdatedNumber(oldNumber, _number);
    }

    // Function to retrieve the stored number
    function getNumber() public view returns (uint256) {
        return storedNumber;
    }
}
