import React from 'react';
import './HeroStyle.css';
import arrow from '../../images/right-arrow.png';

const Hero = () => {
    return (
        <div className='container'>
            <div className='left-container'>
                <h3>Total Aave Deposits in ETH</h3>
                <br />
                <span className='deposits_value'>1.23 M ETH</span>
            </div>

            <div className='right-container'>
                <h3>1. Conditions</h3>
                <div className='form-container'>
                    <div>
                        <label for='Current-Health-Factor'>
                            Current Health Factor
                        </label>
                        <br></br>
                        <div className='threshold_value'>1.03</div>
                        {/* <input type='number'></input> */}

                    </div>
                    <div>

                        <img className='arrow' src={arrow} alt="no-arrow-image" srcset="" />
                    </div>
                    <div>

                        <label for='Desired Health Factor'>
                            Desired Health Factor
                        </label>

                        <div className='threshold_value'>1.10</div>
                    </div>
                </div>

                <div>
                    <div className='form-container-gas'>
                        <div className="form-container-gas">
                            <span className='Set-Gas-Limit'>
                                Set maximum gas price
                            </span>
                            <br></br>
                            <input className='gas-limit-number' type='number' placeholder='100000'></input>
                        </div>
                        <button className='submit' type="submit">Update Threshold</button>
                    </div>
                </div>
                <div>

                </div>

                <h3>2. Collateral</h3>
                <div>
                    <label for='Select Token'>
                        Token to payback the loan
                    </label>
                    {/* <div>
                        <button>AAVE</button><button>BAT</button><button>BUSD</button><button>DAI</button><button>ENJ</button><button>KNC</button><button>LINK</button><button>MANA</button><button>MKR</button><button>REN</button>
                        <button>SNX</button><button>sUSD</button><button>TUSD</button><button>USDC</button><button>USDT</button><button>WBTC</button><button>WETH</button><button>YFI</button><button>ZRX</button><button>UNI</button>
                        <button>AMPL</button>

                    </div> */}
                    <div>

                        <label for='selected tokens'>Tokens: USDC</label>

                    </div>
                    <button className='submit'>Next</button>

                </div>

                <h3>3. Collateral Health Monitor</h3>
                <div>
                    <label for='value of token'>Value of Token: </label>
                    <div className='threshold_value'>$ 1.009</div>
                </div>
                <div>
                    <button className='submit-monitoring'>Start Monitoring</button>
                </div>

            </div>
        </div >

    )
}

export default Hero;