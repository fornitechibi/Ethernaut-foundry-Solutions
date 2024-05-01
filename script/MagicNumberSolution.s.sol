// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {MagicNum} from "../src/MaginNumber.sol";

contract MagicNumberSolution is Script {
    address target = 0x734F30E7C1aAe621eED8b6862ceAe14d8cE1432e;

    function run() external {
        vm.startBroadcast();
        new Hack(MagicNum(target));
        vm.stopBroadcast();
    }
}

contract Hack {
    constructor(MagicNum target) {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        assembly {
            // create(value, offset, size)
            addr := create(0, add(bytecode, 0x20), 0x13)
        }
        target.setSolver(addr);
    }
}
