// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MultiCallTarget {
    function hello(uint _i) external view returns (uint, uint, uint) {
        return (_i, 1, block.timestamp);
    }

    function world() external view returns (uint, uint) {
        return (2, block.timestamp);
    }

    function getDataHello(uint _i) external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.hello.selector, _i);
    }

    function getDataWorld() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.world.selector);
    }
}
