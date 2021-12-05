# Curiosity DAO Token (CC)

This is the set of contracts needed for the deployment of the CC governance token for the Curiosity DAO.
The contracts in `setup.sol` all come from [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts).

Links to specific contracts:

- [Context](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol)<br>
- [Ownable](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol)<br>
- [IERC20](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol)<br>
- [IERC20Metadata](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol)<br>
- [ERC20](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol)<br>
- [ERC20Capped](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Capped.sol)

# Note

Curiosity isn't finished yet. At the moment, I plan to release everything 1st January 2022, but that can change anytime.
I'm a single developer who is also working to publish a newsletter every week and trying to build a community around it.
If you would like to help out with anything (please do), please reach out to me on Twitter @ https://twitter.com/theLucasWalters.
My DM's are always open :)

## Security

If the contract were to be deployed right now, any address could claim an airdrop. I plan to fix this using an Oracle (like Chainlink),
but I don't have that implemented yet.
