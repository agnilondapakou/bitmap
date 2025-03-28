// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Uint256Bitmap {
    uint256 private bitmap;

    error SlotOutOfRange();
    error ValueOutOfRange();
    

    function storeByte(uint8 slot, uint8 value) external {
        require(slot < 32, "Slot out of range");
        require(value <= 255, "Value out of range");

        uint256 mask = ~(uint256(0xFF) << (slot * 8));
        bitmap = (bitmap & mask) | (uint256(value) << (slot * 8));
    }

    function getByte(uint8 slot) external view returns (uint8) {
        require(slot < 32, "Slot out of range");
        return uint8((bitmap >> (slot * 8)) & 0xFF);
    }

    function getAllBytes() external view returns (uint8[32] memory values) {
        for (uint8 i = 0; i < 32; i++) {
            values[i] = uint8((bitmap >> (i * 8)) & 0xFF);
        }
    }
}
