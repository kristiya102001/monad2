// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract EventParticipationSystem {
    struct Event {
        string eventName;
        string organizer;
        uint256 participationDate;
        address participant;
    }

    mapping(address => Event[]) public events;

    function addEvent(string memory eventName, string memory organizer, uint256 participationDate) public {
        events[msg.sender].push(Event({
            eventName: eventName,
            organizer: organizer,
            participationDate: participationDate,
            participant: msg.sender
        }));
    }

    function getEvents(address participant) public view returns (Event[] memory) {
        return events[participant];
    }
}