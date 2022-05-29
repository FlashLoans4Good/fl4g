// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.10;
pragma experimental ABIEncoderV2;

import { IPool } from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {
    IPoolAddressesProvider
} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import { PaybackLoan } from "./PaybackLoan.sol";
import { OpsReady, IOps } from "./OpsReady.sol";
import { Simple } from "./simple.sol";

import {
    SafeERC20,
    IERC20
} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";




interface IResolver {
    function checker()
        external
        view
        returns (bool canExec, bytes memory execPayload);
}


contract PaybackLoanResolver is IResolver, OpsReady{

    Simple simple;
    address public userAccount;
    IPool public immutable POOL;
    uint256 constant HEALTH_FACTOR_LIQUIDATION_THRESHOLD = 1e18;
    uint256 healthTreshold;
    address public USDC = 0x9aa7fEc87CA69695Dd1f879567CcF49F3ba417E2; 

    constructor(IPoolAddressesProvider provider, address user, address _ops, address executedAddress, uint256 _healthTreshold) OpsReady(_ops){
        simple = Simple(executedAddress);
        POOL = IPool(provider.getPool());
        userAccount = user;
        healthTreshold = _healthTreshold;
    }

    // Check if user healthFactor is below 1.1
    // Side note - some delay should be added in the flash loan contract so it dosen't get called every block
    function checker() external view override returns (bool canExec, bytes memory execPayload){
        uint256 healthFactor;
        (, , , ,,healthFactor) = POOL.getUserAccountData(userAccount);
        // Execute when healthFactor < 1.1
        // Also healthFactor that we use as a threeshold could be a parameter
        canExec = healthFactor < HEALTH_FACTOR_LIQUIDATION_THRESHOLD*healthTreshold/10;
        //Change this later to the flashLoan function
        execPayload = abi.encodeWithSelector(
            PaybackLoanResolver.callFlashLoan.selector,
            uint256(healthFactor),
            address(USDC)
        );
    }

    function callFlashLoan(uint256 _amount, address _val) external onlyOps {
        uint256 fee;
        address feeToken;

        (fee, feeToken) = IOps(ops).getFeeDetails();

        _transfer(fee, feeToken);

        //Change to flashLoan
        simple.call(_amount, _val);
    }

        receive() external payable {
        }


}



