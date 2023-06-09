// SPDX-License-Identifier: MIT
"pragma solidity ^0.8.20;

contract ElevatorMaintenanceSystem {
    address public owner;

    struct Elevator {
        uint256 id;
        string brand;
        uint256 installationDate;
        uint256 lastMaintenanceDate;
        uint256 nextMaintenanceDate;
    }

    struct Maintenance {
        uint256 id;
        uint256 elevatorId;
        uint256 maintenanceDate;
        string maintenanceType;
        bool isCompleted;
    }

    uint256 public nextElevatorId;
    uint256 public nextMaintenanceId;

    mapping(uint256 => Elevator) public elevators;
    mapping(uint256 => Maintenance) public maintenances;

    event ElevatorCreated(uint256 id, string brand, uint256 installationDate);
    event MaintenanceCreated(
        uint256 id,
        uint256 elevatorId,
        uint256 maintenanceDate,
        string maintenanceType
    );
    event MaintenanceCompleted(uint256 id);

    modifier onlyOwner() {
        require(msg.sender == owner, 'Only the owner can perform this action');
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createElevator(
        string memory _brand,
        uint256 _installationDate,
        uint256 _nextMaintenanceDate
    ) public onlyOwner {
        elevators<nextElevatorId> = Elevator({
            id: nextElevatorId,
            brand: _brand,
            installationDate: _installationDate,
            lastMaintenanceDate: 0,
            nextMaintenanceDate: _nextMaintenanceDate
        });

        emit ElevatorCreated(
            nextElevatorId,
            _brand,
            _installationDate
        );

        nextElevatorId++;
    }

    function createMaintenance(
        uint256 _elevatorId,
        uint256 _maintenanceDate,
        string memory _maintenanceType
    ) public onlyOwner {
        maintenances<nextMaintenanceId> = Maintenance({
            id: nextMaintenanceId,
            elevatorId: _elevatorId,
            maintenanceDate: _maintenanceDate,
            maintenanceType: _maintenanceType,
            isCompleted: false
        });

        emit MaintenanceCreated(
            nextMaintenanceId,
            _elevatorId,
            _maintenanceDate,
            _maintenanceType
        );

        nextMaintenanceId++;
    }

    function completeMaintenance(uint256 _maintenanceId) public onlyOwner {
        Maintenance storage maintenance = maintenances<_maintenanceId>;
        require(!maintenance.isCompleted, 'Maintenance already completed');

        Elevator storage elevator = elevators<maintenance.elevatorId>;
        elevator.lastMaintenanceDate = maintenance.maintenanceDate;
        
        maintenance.isCompleted = true;
        emit MaintenanceCompleted(_maintenanceId);
    }

    function updateNextMaintenanceDate(
        uint256 _elevatorId,
        uint256 _nextMaintenanceDate
    ) public onlyOwner {
        Elevator storage elevator = elevators<_elevatorId>;
        elevator.nextMaintenanceDate = _nextMaintenanceDate;
    }
}"
