import { useState } from 'react';
import { ethers, BigNumber } from 'ethers';
import IPollAddressProvider from './fl4g.json';

const healthFactorAddress = '0x351c3eC6EE2E9908468356B55344A7b617b61168';

const HealthFactors = ({ accounts, setAccounts }) => {
    cosnt[healthFactor, setHealthFactor] = useState(1);
    const isConnected = Boolean(accounts[0]);

    async function handleHealthFactor() {
        if (window.ethereum) {
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new ethers.Contract(
                healthFactorAddress,
                IPollAddressProvider.abi,
                signer,

            );

            try {
                const response = await contract.getAaveHealthFactor(BigNumber.from())
            }
            
        }
    }
}
    

