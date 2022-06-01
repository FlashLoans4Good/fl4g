// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;
pragma experimental ABIEncoderV2;

import {
    IPoolAddressesProvider
} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import { IPool } from "@aave/core-v3/contracts/interfaces/IPool.sol";
import { IFlashLoanSimpleReceiver } from "@aave/core-v3/contracts/flashloan/interfaces/IFlashLoanSimpleReceiver.sol";
import { IERC20 } from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";
import { SafeMath } from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/SafeMath.sol";

interface IFaucet {
    function mint(
        address _token,
        uint256 _amount
    ) external;
}

abstract contract FlashLoanSimpleReceiverBase is IFlashLoanSimpleReceiver {
  using SafeMath for uint256;

  IPoolAddressesProvider public immutable override ADDRESSES_PROVIDER;
  IPool public immutable override POOL;
  IFaucet public immutable FAUCET;

  constructor(IPoolAddressesProvider provider, IFaucet faucet) {
    ADDRESSES_PROVIDER = provider;
    POOL = IPool(provider.getPool());
    FAUCET = faucet;
  }
}


/** 
    !!!
    Never keep funds permanently on your FlashLoanSimpleReceiverBase contract as they could be 
    exposed to a 'griefing' attack, where the stored funds are used by an attacker.
    !!!
 */
contract PaybackLoan is FlashLoanSimpleReceiverBase {
    using SafeMath for uint256;

    // for flashLoanSimple
    // single asset 
    // USDC address - https://mumbai.polygonscan.com/token/0x9aa7fec87ca69695dd1f879567ccf49f3ba417e2
    address immutable USDC_ASSET = 0x9aa7fEc87CA69695Dd1f879567CcF49F3ba417E2;
    // test subscriber devtest
    address constant testaddress = 0xf1c463aB9791911D7CF896BFB994cB157E6d441B;


    /// 1. Called first. 
    constructor(IPoolAddressesProvider _addressProvider, IFaucet _faucet) FlashLoanSimpleReceiverBase(_addressProvider, _faucet) {}

    /// 2. Called 2nd after constructor
    /// function borrows a single asset ie. USDC 
    /// @param asset is USDC 
    /// @param amount is Amount of asset being requested for flash borrow  
    /// @dev add logic for repaying loan as well? 
    function executeFlashLoan(
        address asset,
        uint256 amount
    ) public {
        // when flashLoanSimple finishes executing funds are sent to receiverAddress
        address receiverAddress = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        // Calculate balance of contract
        // do a check to make sure balance sufficient

        // amount comes from test-aave-flash-loan
        POOL.flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }

    /// 3. Called third
    /// This function is called by Aave after the POOL.flashLoanSimple call 
    /// When completed this contract now has received the flash loaned amount
    /// @param asset in this case USDC 
    /// @param amount the amount that we borrowed
    /// @param premium fees to pay back for borrowing
    /// @param initiator the contract that executed the flash loan in this case "this contract"
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    )
        external
        override
        returns (bool)
    {

        // This contract now has the funds requested from the executeFlashLoan function
        // Business logic - note: assume subscriber has a debt position opened on Aave, deposited <= 1ETH, and collateralised. 
        // 1. This contract calls 
        // 2. (Manually monitor health score for demo) Run script to cause health score to drop to liquidation threshold subscriber set

        // 3. Execute flashLoanSimple

        // 4. Repay portion of subscriber's loan to boost health score with aUSDC

        // (1) First attempt to repay loan with user's aTokens ie. aUSDC 
        // Interest rate mode of the debt position
        // 1 - stable
        // 2 - variable
        uint256 interestRateMode = 2;
        // do i need an approval here? 
        // uint256.max what does this do? see IPool.sol
        // type(uint256).max repays the whole debt 
        // returns the final amount repaid. 
        uint256 amountRepaid = POOL.repayWithATokens(asset, type(uint256).max, interestRateMode);
        
        
        // check health factor <= 1.1 
        (, , , , , uint256 healthFactor) = POOL.getUserAccountData(testaddress);
        if(amountRepaid > 0 && healthFactor < 1) {
            executeFlashLoan(asset, amount);
        }
        // throw error emit event
        // (2) 


        // 5. Transfer collected collateral to subscribers wallet (Collateral - transaction fees)  
        // 6. Repay to Aave (Collateral Balance - flashloaned amount + premium). Note: ensure enough funds in contract
        

        // Step 6. Approve the LendingPool contract allowance to *pull* the owed amount
        uint amountOwed = amount.add(premium);
        FAUCET.mint(asset,premium);
        IERC20(asset).approve(address(POOL), amountOwed);

        return true;
    }
}