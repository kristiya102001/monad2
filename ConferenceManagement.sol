// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ConferenceManagement {
    struct Conference {
        string name;
        string location;
        uint256 startDate;
        uint256 endDate;
        address[] participants;
        bool isActive;
    }

    mapping(uint256 => Conference) public conferences;
    uint256 public conferenceCount;

    event ConferenceAdded(uint256 indexed conferenceId, string name, string location, uint256 startDate, uint256 endDate);
    event ParticipantRegistered(uint256 indexed conferenceId, address participant);
    event ConferenceEnded(uint256 indexed conferenceId);

    function addConference(string memory _name, string memory _location, uint256 _startDate, uint256 _endDate) public {
        conferences[conferenceCount] = Conference({
            name: _name,
            location: _location,
            startDate: _startDate,
            endDate: _endDate,
            participants: new address[](0),
            isActive: true
        });
        emit ConferenceAdded(conferenceCount, _name, _location, _startDate, _endDate);
        conferenceCount++;
    }

    function registerForConference(uint256 _conferenceId) public {
        Conference storage conference = conferences[_conferenceId];
        require(conference.isActive, "Conference is not active");
        require(block.timestamp < conference.startDate, "Registration period is over");
        for (uint256 i = 0; i < conference.participants.length; i++) {
            require(conference.participants[i] != msg.sender, "Already registered");
        }
        conference.participants.push(msg.sender);
        emit ParticipantRegistered(_conferenceId, msg.sender);
    }

    function endConference(uint256 _conferenceId) public {
        Conference storage conference = conferences[_conferenceId];
        require(block.timestamp >= conference.endDate, "Conference has not ended yet");
        conference.isActive = false;
        emit ConferenceEnded(_conferenceId);
    }

    function getConference(uint256 _conferenceId) public view returns (string memory, string memory, uint256, uint256, address[] memory, bool) {
        Conference storage conference = conferences[_conferenceId];
        return (conference.name, conference.location, conference.startDate, conference.endDate, conference.participants, conference.isActive);
    }
}