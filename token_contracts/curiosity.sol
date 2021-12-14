// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

/**
 * @dev For details, read the README.md file in the Github repo @ https://github.com/Curiosity-DAO/Curiosity-DAO/blob/main/README.md
 */

// Setup

import "./setup.sol";

// set a hard cap on number of tokens
uint constant initialSupply = 5000000 ether; // 5 million tokens

// tokens to be airdropped to DAO members
uint constant dropSupply = 1500000 ether; // 1.5 million

// the rest to be sent to the DAO
uint constant remainder = initialSupply - dropSupply; // 3.5 million

// number of drops
uint8 constant drops = 30; // current number of CC readers

// size of each drop
uint constant dropSize = dropSupply / drops; // 50,000 tokens per reader

/**
 * @title Curiosity
 * @author Lucas Walters - https://www.github.com/theLucasWalters
 */
contract Curiosity is ERC20, Ownable {

    /// mapping to assign a bool value to an address; used to check if the address has already claimed a drop
    mapping (address => bool) alreadyClaimed;

    /// number of tokens left to be minted; starts at 1.5 million
    uint internal _tokensLeft = dropSupply;

    /// number of drops left
    uint8 internal _drops = drops;

    /// Event to broadcast that an airdrop has been claimed
    event dropClaimed(address receiver, uint amount);

    /// Event to broadcast that new tokens have been minted
    event newMinted(address receiver, uint amount);

    /// DAO Treasury address
    address private immutable _daoTreasury = 0x65a0021268Bd6c021dFfe781990f6885c8D2C72B; // burner address; will probably change later

    /// Name of the token is Curiosity (same as the DAO) and the symbol is CC
    constructor() ERC20("Curiosity", "CC") {

        /// Mint tokens not reserved for the drop to the DAO
        _mint(_daoTreasury, remainder);

        /// broadcast that new tokens have been minted
        emit newMinted(_daoTreasury, remainder);
    }

    modifier onlyOnce {
        require(!alreadyClaimed[msg.sender]);
        _;
    }

    /// Airdrop mechanism
    function claim() public onlyOnce {

        /// immediately set `alreadyClaimed` to true to avoid bot attacks
        alreadyClaimed[msg.sender] = true;

        /// mint to the address calling
        _mint(msg.sender, dropSize);

        /// emit `newMinted` event
        emit newMinted(msg.sender, dropSize);

        /// subtract amount minted from the tokens left and lower number of drops left by 1
        _tokensLeft -= dropSize;
        _drops--;

        /// emit a `dropClaimed` event
        emit dropClaimed(msg.sender, dropSize);
    }

    /// Allows DAO to mint new tokens
    function mintNew(uint amount) external onlyOwner {

        /// mint to the DAO Treasury
        _mint(_daoTreasury, amount);

        /// broadcast that new tokens have been minted
        emit newMinted(_daoTreasury, amount);
    }

    /**
     * @return the address of the DAO Treasury
     */
    function getDaoAddress() external view returns (address) {
        return _daoTreasury;
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

    /**
     * @return if an address has already claimed an airdrop
     */
    function hasClaimed(address account) external view returns (bool) {
        return alreadyClaimed[account];
    }
}
