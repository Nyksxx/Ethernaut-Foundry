pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../CoinFlip/CoinFlipAttack.sol";
import "../CoinFlip/CoinFlipFactory.sol";
import "../Ethernaut.sol";
import "./utils/vm.sol";

contract CoinFlipTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contracts
        ethernaut = new Ethernaut();
    }

    function testCoinFlipHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        CoinFlipFactory coinFlipFactory = new CoinFlipFactory();
        ethernaut.registerLevel(coinFlipFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(coinFlipFactory);
        CoinFlip ethernautCoinFlip = CoinFlip(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        // Move the block from 0 to 5 to prevent underflow errors
        vm.roll(5);

        // Create coinFlipHack contract
        CoinFlipAttack coinFlipAttack = new CoinFlipAttack(levelAddress);

        // Run the attack 10 times, iterate the block each time
        for (uint256 i = 0; i <= 10; i++) {
            vm.roll(6 + i);
            coinFlipAttack.attack();
        }

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(
            payable(levelAddress)
        );
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
