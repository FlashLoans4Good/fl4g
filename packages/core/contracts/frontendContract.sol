// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.10;
pragma experimental ABIEncoderV2;


import { IPool } from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {
    IPoolAddressesProvider
} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";

contract FrontendData{

    IPool public immutable POOL;
    address public userAccount;

   constructor(IPoolAddressesProvider provider, address user){
        POOL = IPool(provider.getPool());
        userAccount = user;
    }

    function getAaveHealthFactor() public view returns(uint256){
        uint256 healthFactor;
        (, , , ,,healthFactor) = POOL.getUserAccountData(userAccount);
        return healthFactor;
    }
}