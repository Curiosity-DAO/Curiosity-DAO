// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

/**
 * @dev For details, read the README.md file in the Github repo @ https://www.github.com/theLucasWalters/Curiosity-DAO
 */

// Setup

import "./setup.sol";

// set a hard cap on number of tokens
uint constant total = 100000000 ether; // 100 million tokens

// tokens to be airdropped to DAO members
uint constant dropSupply = total / 10; // 10% of total (10 million tokens)

// the rest to be sent to the DAO
uint constant remainder = total - dropSupply; // 90% or 90 million tokens)

// number of drops
uint constant drops = 25; // current number of CC readers

// size of each drop
uint constant dropSize = dropSupply / drops; // 400,000 tokens per reader *mind-blown emoji*

/**
 * @title Curiosity
 * @author Lucas Walters - https://www.github.com/theLucasWalters
 */
contract Curiosity is ERC20Capped, Ownable {

    /// number of tokens left to be minted; starts at 10 million
    uint internal _tokensLeft = 10000000 ether;

    /// number of drops left
    uint8 internal _drops = 25;

    /// Event to broadcast that an airdrop has been claimed
    event dropClaimed(address receiver, uint amount);

    /// DAO Treasury address
    address private immutable _daoTreasury = 0x65a0021268Bd6c021dFfe781990f6885c8D2C72B; // burner address; will probably change later

    /// Whitelist of wallet addresses to receive airdrops
    address[] private _dropList = [
        0xe4e1487dBbEC9Fc7e6a363A37b71A9672dAD358c, // Lucas Walters
        0x0DE94050c661D1012F9b1DC93C91fE58b7dfEbF5  // alecfwilson.eth
    ];

    /// Name of the token is Curiosity (same as the DAO) and the symbol is CC
    constructor() ERC20("Curiosity", "CC") ERC20Capped(100000000 ether) {
        /// Mint tokens not reserved for the drop to the DAO
        _mint(_daoTreasury, remainder);
    }

    /**
     * @return the address of the DAO Treasury
     */
    function getDaoAddress() external view returns (address) {
        return _daoTreasury;
    }

    /**
     * @return the list of addresses on the airdrop whitelist
     */
    function getDropList() external view returns (address[] memory) {
        return _dropList;
    }

    /**
     * @return number of tokens left to mint
     */
    function remainingTokens() external view returns (uint) {
        return _tokensLeft;
    }

    /**
     * @return number of airdrops left
     */
    function remainingDrops() external view returns (uint8) {
        return _drops;
    }

    /// Airdrop mechanism
    function claim() public {
        _mint(msg.sender, dropSize);
        _tokensLeft -= dropSize;
        _drops--;
        emit dropClaimed(msg.sender, dropSize);
    }
}
