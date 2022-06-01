import React from 'react';
import './Application_Form_Style.css';
import arrow from '../../images/right-arrow.svg';

const Application_Form = () => {
    return (
        <div className='container'>
            <div className='left-container'>
                <h3>Total Aave Deposits in ETH</h3>
            </div>

            <div className='right-container'>
                <h3>1. Conditions</h3>
                <div className='form-container'>
                    <div>
                        <label for='Current-Health-Factor'>
                            Current Health Factor
                        </label>
                        <br></br>
                        {/* <input type='number'></input> */}

                    </div>
                    <div>

                        <img className='arrow' src={arrow} srcset="" />
                    </div>
                    <div>Current Liquidation Threshold</div>
                </div>

                {/* <div>
                    <div className='form-container-gas'>
                        <label for='Set-Gas-Limit'>
                            Set your gas limit for the flash loan contract
                        </label>
                            <input type='number' placeholder='100000'></input>
                        <button className='submit' type="submit">Update Threshold</button>
                    </div>
                </div> */}
                <div>
                    <div className="form-container-gas">
                        <span className='Set-Gas-Limit'>
                            Set your gas limit for the flash loan contract
                        </span>
                        <br></br>
                        <input type='number' placeholder='100000'></input>
                    </div>
                </div>



                <h3>2. Collateral</h3>
                <div>
                    <label for='Select Token'>
                        Select Tokens to payback the loan
                    </label>
                    <div>
                        <button>AAVE</button><button>BAT</button><button>BUSD</button><button>DAI</button><button>ENJ</button><button>KNC</button><button>LINK</button><button>MANA</button><button>MKR</button><button>REN</button>
                        <button>SNX</button><button>sUSD</button><button>TUSD</button><button>USDC</button><button>USDT</button><button>WBTC</button><button>WETH</button><button>YFI</button><button>ZRX</button><button>UNI</button>
                        <button>AMPL</button>

                    </div>
                    <div>

                        <label for='selected tokens'>Selected Tokens:</label>

                    </div>

                </div>

                <h3>3. Monitoring</h3>
                <div>
                    <label for='value of token'>Value of Token:</label>
                </div>

                <div>
                    <button className='submit' type="submit">Submit</button>

                </div>

            </div>
        </div>

    )
}

export default Application_Form