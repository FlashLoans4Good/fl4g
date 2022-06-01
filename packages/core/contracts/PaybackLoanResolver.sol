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

    PaybackLoan paybackLoan;
    address public userAccount;
    address public owner;
    //4000 USDC, make dynamic later
    uint256 amount = 4000*1000000;
    IPool public immutable POOL;
    uint256 constant HEALTH_FACTOR_LIQUIDATION_THRESHOLD = 1e18;
    uint256 healthTreshold;
    address public USDC = 0x9aa7fEc87CA69695Dd1f879567CcF49F3ba417E2; 

    constructor(IPoolAddressesProvider provider, address user, address _ops, PaybackLoan _paybackLoan, uint256 _healthTreshold) OpsReady(_ops){
        paybackLoan = _paybackLoan;
        POOL = IPool(provider.getPool());
        userAccount = user;
        healthTreshold = _healthTreshold;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "FlashLoanResolver: onlyOwner");
        _;
    }

    // Check if user healthFactor is below 1.1
    // Side note - some delay should be added in the flash loan contract so it dosen't get called every block
    function checker() external view override returns (bool canExec, bytes memory execPayload){
        uint256 healthFactor;
        (, , , ,,healthFactor) = POOL.getUserAccountData(userAccount);
        // Execute when healthFactor < 1.1
        // Also healthFactor that we use as a threeshold could be a parameter
        canExec = healthFactor < HEALTH_FACTOR_LIQUIDATION_THRESHOLD*healthTreshold/100;
        //Change this later to the flashLoan function
        execPayload = abi.encodeWithSelector(
            PaybackLoanResolver.callFlashLoan.selector,
            address(USDC),
            uint256(amount)
        );
    }

    //Gelato executes this function
    function callFlashLoan(address _asset, uint256 _amount) external onlyOps {
        uint256 fee;
        address feeToken;

        (fee, feeToken) = IOps(ops).getFeeDetails();

        _transfer(fee, feeToken);

        //Change to flashLoan
        paybackLoan.executeFlashLoan(_asset, _amount);
    }

    //Set healthTreshold to _healthTreshold/100
    function setHealthTreshold(uint16 _healthTreshold) public onlyOwner{
        healthTreshold = _healthTreshold;
    }

    //Returns health factor with two decimal places
    function getCurrentTreshold() public view returns(uint256){
        return healthTreshold;
    }

    function updateOwner(address _owner) public onlyOwner{
        owner = _owner;
    }

    function setPaybackFlashLoanAddress(PaybackLoan _paybackLoan) public onlyOwner{
        paybackLoan = _paybackLoan;
    }

    function setUser(address _user) public onlyOwner{
        userAccount = _user;
    }

    receive() external payable {
    }


}



