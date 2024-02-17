// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level0Solution is Script {
    Instance public level0 =
        Instance(0x361b35060985C333a75121371688c569caE353F0);

    function run() external {
        string memory password = level0.password();
        console.log("Password: ", password);
        vm.startBroadcast();
        level0.authenticate(password);
        vm.stopBroadcast();
    }
}
