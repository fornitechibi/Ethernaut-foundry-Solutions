// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {King} from "../src/King.sol";
import {Test, console} from "forge-std/Test.sol";

contract KingSolution is Test {
    King public king;
    address public kingAddress;
    address public ATTACKER = makeAddr("attacker");
    uint256 public constant BALANCE = 0.001 ether;

    function setUp() public payable {
        king = new King{value: BALANCE}();
        kingAddress = address(king);
        console.log("The owner is: ", msg.sender);
    }

    function testKing() public payable {
        vm.deal(ATTACKER, 10 ether);
        vm.startPrank(ATTACKER);
        address(king).call{value: king.prize()}("");
        console.log("The new owner is: ", king._king());
        console.log("The address of the attacker: ", address(this));
        vm.stopPrank();
    }
}

import {KingSolution} from "./KingSolution.t.sol";

contract NewUser is Test {
    King public newUser;
    KingSolution public king;
    address public USER = makeAddr("user");

    function setUp() public payable {
        newUser = King(payable(king.kingAddress()));
    }

    function testSecondKing() public {
        vm.deal(USER, 10 ether);
        vm.startPrank(USER);
        address(newUser).call{value: 0.01 ether}("");
        vm.stopPrank();
    }
}
