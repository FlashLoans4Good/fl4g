// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.10;
pragma experimental ABIEncoderV2;

import { IPool } from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {
    IPoolAddressesProvider
} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";

//Delete later
contract Counter {
    uint256 public count  = 0;

    function add() public {
        count++;
    }


}


interface IResolver {
    function checker()
        external
        view
        returns (bool canExec, bytes memory execPayload);
}

contract PaybackLoanResolver is IResolver{

    address public userAccount;
    IPool public immutable POOL;
    uint256 public constant HEALTH_FACTOR_LIQUIDATION_THRESHOLD = 1e18;

    constructor(IPoolAddressesProvider provider, address user){
        POOL = IPool(provider.getPool());
        userAccount = user;
    }

    // Check if user healthFactor is below 1.1
    // Side note - some delay should be added in the flash loan contract so it dosen't get called every block
    function checker() external view override returns (bool canExec, bytes memory execPayload){
        uint256 healthFactor;
        (, , , ,,healthFactor) = POOL.getUserAccountData(userAccount);
        // Execute when healthFactor < 1.1
        // Also healthFactor that we use as a threeshold could be a parameter
        canExec = healthFactor < HEALTH_FACTOR_LIQUIDATION_THRESHOLD*11/10;
        //Change this later to the flashLoan function
        execPayload = abi.encodeWithSelector(
            Counter.add.selector
        );
    }

}
