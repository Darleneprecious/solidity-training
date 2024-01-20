// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Arithmetic {
   
    function isOdd(uint256 number) public pure returns (bool) {
        if (number % 2 != 0) {
            return true;
        } else {
            return false;
        }
    }

 
    function isEven(uint256 number) public pure returns (bool) {
        if (number % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }

    
    function findMostSignificantBit(uint256 number) public pure returns (uint256) {
        if (number == 0) {
            return 0;
        }

        uint256 msb = 0;
        while (number > 0) {
            number >>= 1; 
            msb++;
        }

        return msb;
    }
}
