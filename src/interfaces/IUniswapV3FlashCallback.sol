// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

interface IUniswapV3FlashCallback{
    function uniswapV3FlashCallback(bytes memory data) external;
}