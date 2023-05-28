// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    mapping(address => uint256) private _lastClaim;
    uint256 public constant RATE = 1; // Rate of token minting per second

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint 100 tokens to msg.sender
        // Similar to how
        // 1 dollar = 100 cents
        // 1 token = 1 * (10 ** decimals)
        _mint(msg.sender, 100 * 10**uint(decimals()));
    }

    function claimTokens() public {
        uint256 lastClaim = _lastClaim[msg.sender];
        if (lastClaim == 0) {
            lastClaim = block.timestamp;
        }

        uint256 elapsedTime = block.timestamp - lastClaim;
        uint256 reward = elapsedTime * RATE;

        _mint(msg.sender, reward);
        _lastClaim[msg.sender] = block.timestamp;
    }
}