// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/bitmap.sol";

contract Uint256BitmapTest is Test {
    Uint256Bitmap bitmap;

    function setUp() public {
        bitmap = new Uint256Bitmap();
    }

    function testStoreAndGetByte() public {
        bitmap.storeByte(5, 123);
        uint8 value = bitmap.getByte(5);

        assertEq(value, 123, "Stored value mismatch");
    }

    function testStoreMultipleBytes() public {
        bitmap.storeByte(0, 42);
        bitmap.storeByte(10, 99);
        bitmap.storeByte(31, 255);

        assertEq(bitmap.getByte(0), 42, "Value at slot 0 mismatch");
        assertEq(bitmap.getByte(10), 99, "Value at slot 10 mismatch");
        assertEq(bitmap.getByte(31), 255, "Value at slot 31 mismatch");
    }

    function testGetAllBytes() public {
        bitmap.storeByte(0, 10);
        bitmap.storeByte(15, 200);
        bitmap.storeByte(31, 55);

        uint8[32] memory values = bitmap.getAllBytes();

        assertEq(values[0], 10, "Mismatch at slot 0");
        assertEq(values[15], 200, "Mismatch at slot 15");
        assertEq(values[31], 55, "Mismatch at slot 31");
    }

    function testSlotOutOfRange() public {
        vm.expectRevert("Slot out of range");
        bitmap.storeByte(32, 50);

        vm.expectRevert("Slot out of range");
        bitmap.getByte(32);
    }
}
