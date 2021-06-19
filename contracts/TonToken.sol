// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TonToken is ERC20 {
    constructor() ERC20("TON Token", "TON") {}
}
