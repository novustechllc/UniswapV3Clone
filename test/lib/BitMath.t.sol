// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {BitMath} from "../../src/lib/BitMath.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

// To run this tests execute on the terminal:
// FOUNDRY_FUZZ_RUNS=n forge test --mc BitMathDifferentialTesting --ffi

contract BitMathDifferentialTesting is Test {

    using Strings for uint256;

    function setUp() public {}

    function ffi_leastAndMostSignificantBit(uint256 word, bool isLeast) private returns(uint8){
        string[] memory inputs = new string[](4);
        inputs[0] = "python3";
        inputs[1] = "mostAndLeastSignificantBit.py";
        inputs[2] = word.toString();
        if(isLeast){
            inputs[3] = "least";
        } else {
            inputs[3] = "most";
        }

        bytes memory res = vm.ffi(inputs);

        uint8 result = abi.decode(res, (uint8));

        return result;
    }

    function testLeastSignificantBit(uint256 word) public {
        vm.assume(word > 0);

        uint8 pythonResult = ffi_leastAndMostSignificantBit(word, true);
        uint8 solidityResult = BitMath.leastSignificantBit(word);

        assertEq(solidityResult, pythonResult);
    }

    function testMostSignificantBit(uint256 word) public {
        vm.assume(word > 0);

        uint8 pythonResult = ffi_leastAndMostSignificantBit(word, false);
        uint8 solidityResult = BitMath.mostSignificantBit(word);

        assertEq(solidityResult, pythonResult);
    }
}