//SPDX-License-Identifier:MIT

pragma solidity^0.8.19;

import {Script} from "forge-std/Script.sol";
import {GameStake} from "src/game.sol";

contract deploy is Script{
    GameStake gameStake;

    function run() public {
        vm.startBroadcast();
        gameStake = new GameStake();
        vm.stopBroadcast();
    }
}