// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract EmployeeTrainingSystem {
    struct Training {
        string trainingName;
        string trainer;
        uint256 completionDate;
        address employee;
    }

    mapping(address => Training[]) public trainings;

    function addTraining(string memory trainingName, string memory trainer, uint256 completionDate) public {
        trainings[msg.sender].push(Training({
            trainingName: trainingName,
            trainer: trainer,
            completionDate: completionDate,
            employee: msg.sender
        }));
    }

    function getTrainings(address employee) public view returns (Training[] memory) {
        return trainings[employee];
    }
}