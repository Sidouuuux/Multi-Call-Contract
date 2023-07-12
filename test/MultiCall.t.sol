// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MultiCall.sol";
import "../src/MultiCallTarget.sol";

contract CounterTest is Test {
    MultiCall public multi;
    MultiCallTarget public target;

    function setUp() public {
        multi = new MultiCall();
        target = new MultiCallTarget();
    }

    function testMultiCall() public {
        uint _i = 9;
        bytes memory dataHello = target.getDataHello(_i);
        bytes memory dataWorld = target.getDataWorld();

        address[] memory targets = new address[](2);
        bytes[] memory data = new bytes[](2);

        targets[0] = address(target);
        targets[1] = targets[0];
        data[0] = dataHello;
        data[1] = dataWorld;
        bytes[] memory result = multi.multiCall(targets, data);
        uint a;
        uint b;
        uint c;
        uint d;
        uint e;
        (a, b, c) = abi.decode(result[0], (uint, uint, uint));
        (d, e) = abi.decode(result[1], (uint, uint));
        assertEq(_i, 9, '_i not equal');
        assertEq(b, 1, 'b have wrong value');
        assertEq(c, 1, 'c have wrong value');
        assertEq(d, 2, 'd have wrong value');
        assertEq(e, 1, 'e have wrong value');
    }
}
