const PaybackLoan = artifacts.require("PaybackLoan");

module.exports = async function(deployer) {
    //Deploy PaybackLoan
    // const poolAddress = "0x5343b5bA672Ae99d627A1C87866b8E53F47Db2E6";
    // const faucetAddress = "0xc1eB89DA925cc2Ae8B36818d26E12DDF8F8601b0";
    await deployer.deploy(PaybackLoan, "0x5343b5bA672Ae99d627A1C87866b8E53F47Db2E6", "0xc1eB89DA925cc2Ae8B36818d26E12DDF8F8601b0");
    const paybackLoan = await PaybackLoan.deployed()
};