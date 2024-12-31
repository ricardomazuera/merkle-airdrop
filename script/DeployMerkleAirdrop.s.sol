// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {MerkleAirdrop, IERC20} from "src/MerkleAirdrop.sol";
import {BananaToken} from "src/BananaToken.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    // 4 users, 25 Banana tokens each
    uint256 public AMOUNT_TO_TRANSFER = 4 * (25 * 1e18);

    // Deploy the airdrop contract and bagel token contract
    function deployMerkleAirdrop() public returns (MerkleAirdrop, BananaToken) {
        vm.startBroadcast();
        BananaToken bananaToken = new BananaToken();
        MerkleAirdrop airdrop = new MerkleAirdrop(ROOT, IERC20(bananaToken));
        // Send Banana tokens -> Merkle Air Drop contract
        bananaToken.mint(bananaToken.owner(), AMOUNT_TO_TRANSFER);
        IERC20(bananaToken).transfer(address(airdrop), AMOUNT_TO_TRANSFER);
        vm.stopBroadcast();
        return (airdrop, bananaToken);
    }

    function run() external returns (MerkleAirdrop, BananaToken) {
        return deployMerkleAirdrop();
    }
}
