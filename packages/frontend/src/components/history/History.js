import React from 'react'
import './HistoryStyle.css';

const History = () => {
    return (
        <div className='history-container'>
            
            <h2>History of Transactions</h2>
            <table>
                <thread>
                    <tr>
                        <th>Time Stamp</th>
                        <th>Assets Transfered</th>
                        <th>Transaction Fees</th>
                        <th>Collateral Sent(ETH)</th>
                        <th>Transaction Hash</th>


                    </tr>

                    <tbody>
                        <tr>
                            <td>30/05/2022 1300</td>
                            <td><button className='usdc'>USDC</button></td>
                            <td>0.15 ETH</td>
                            <td>$ 12,200.67</td>
                            <td>0xc1234wdsdcsasu5tgjhjghsd</td>


                        </tr>
                        <tr>
                            <td>31/05/2022 0630</td>
                            <td><button className='usdc'>USDC</button></td>
                            <td>0.17 ETH</td>
                            <td>$ 1,560.66</td>
                            <td>0xcbcbcbvcbcsas1233dasdasd</td>


                        </tr>
                    </tbody>
                </thread>
            </table>

        </div>
    )
}

export default History