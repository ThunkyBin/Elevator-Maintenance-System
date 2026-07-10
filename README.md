# Elevator Maintenance System

Solidity smart contract prototype for tracking elevator assets and their
maintenance records on-chain.

## Quick Start

```bash
npm install
npm test
```

`npm run compile` writes ABI and bytecode artifacts to `build/`. GitHub Actions
runs the smoke test automatically for every push and pull request.

## Contract

`ElevatorMaintenance.sol` contains `ElevatorMaintenanceSystem`, an owner-managed
contract with two registries:

- `elevators` stores elevator brand, installation date, last maintenance date,
  and next maintenance date.
- `maintenances` stores scheduled maintenance records and completion state.

## Workflow

1. The owner deploys the contract.
2. The owner registers an elevator with `createElevator`.
3. The owner schedules a maintenance record with `createMaintenance`.
4. The owner marks a maintenance record complete with `completeMaintenance`.
5. The owner can update the next planned maintenance date with
   `updateNextMaintenanceDate`.

## Main Functions

- `createElevator(string brand, uint256 installationDate, uint256 nextMaintenanceDate)`
- `createMaintenance(uint256 elevatorId, uint256 maintenanceDate, string maintenanceType)`
- `completeMaintenance(uint256 maintenanceId)`
- `updateNextMaintenanceDate(uint256 elevatorId, uint256 nextMaintenanceDate)`

## Events

- `ElevatorCreated`
- `MaintenanceCreated`
- `MaintenanceCompleted`

## Notes

- Dates are stored as Unix timestamps.
- Only the deployer/owner can create or update records.
- The contract validates elevator and maintenance IDs before updating records.
- This is a learning prototype and should be audited before production use.
