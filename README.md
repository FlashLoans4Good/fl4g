# FL4G (Built at ETHShanghai 2022 Hackathon)
FL4G (FlashLoans4Good) is a liquidation protection platform built to serve mainstream borrowers.  

# Project Overview
One of the biggest problems in decentralised finance (DeFi) today is market volatility which can lead to costly liquidations and hence the loss of money.
Flashloans4Good uses flash loans as a force for good to protect that money by minimising collateral losses from costly liquidations. These users want to utilise DeFi to borrow with the goal of improving their lives in some way. They take on good debt such as to pay for education, fund a business, or own a home.  We strongly believe that by simplifying the user experience and by minimising collateral losses due to liquidations this can help to drive the mass adoption of DeFi.  

# Architecture 
![Architecture Diagram](https://github.com/FlashLoans4Good/fl4g/blob/6dbd0f58b127b809356ffd48a0b14e1f8c9fd12f/diagrams/architectureV2.1.jpeg)



# Build & Run platform (locally)
## Launch frontend
1. cd packages/core/interface
2. npm install
3. npm run 

# Deploy to Polygon Mumbai 
1. Install truffle with npm install -g truffle
2. Add matic network to truffle-config.js > refer https://docs.polygon.technology/docs/develop/truffle/
3. Create .env file with INFURA and MNEMONIC info > refer https://forum.openzeppelin.com/t/testnet-deployment-error-could-not-create-addresses-from-your-mnemonic-or-private-key-s/4461
4. truffle migrate --network matic

# Testing procedure 
1. Install Ganache refer > https://trufflesuite.com/ganache/
2. Once installed Launch (aka start) > create new workspace or quickstart (in this case, we have a workspace called ETH SHANGHAI 2022 HACKATHON)  
3. Ensure RPC server is pointing to port 8545 and that matches the development network port in truffle-config.js
4. cd packages/core
5. truffle test test/test-aave-flash-loan.js

## Contract Addresses

### PoolAddressesProvider

- Mumbai V3: 0x5343b5bA672Ae99d627A1C87866b8E53F47Db2E6

### Aave Faucets

- Mumbai V3: 0xc1eB89DA925cc2Ae8B36818d26E12DDF8F8601b0

### Gelato Network Ops

- Mumbai V3: 0xB3f5503f93d5Ef84b06993a1975B9D21B962892F

### Gelato Network TaskTreasury
- Mumbai V3: 0x527a819db1eb0e34426297b03bae11F2f8B3A19E
