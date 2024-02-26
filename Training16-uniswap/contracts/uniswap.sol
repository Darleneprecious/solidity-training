// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

contract MyContract {
    ISwapRouter public swapRouter;

    constructor(address _swapRouter) {
        swapRouter = ISwapRouter(_swapRouter);
    }

  function swapExactTokensForTokens(
    uint256 amountIn,
    uint256 amountOutMinimum,
    address[] calldata path,
    address to,
    uint256 deadline
) external {
    swapRouter.exactInputSingle(ISwapRouter.ExactInputSingleParams({
        tokenIn: path[0],
        tokenOut: path[1],
        fee: 500,
        recipient: to,
        deadline: deadline,
        amountIn: amountIn,
        amountOutMinimum: amountOutMinimum,
        sqrtPriceLimitX96: 0
    }));
}

}
