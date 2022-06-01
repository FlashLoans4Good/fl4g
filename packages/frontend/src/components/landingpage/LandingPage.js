import { React, useEffect } from 'react'
import './LandingPageStyle.css';
import { useMoralis } from "react-moralis";
import logo from '../../images/logo-fl4g.png';

const LandingPage = () => {

    const { authenticate, isAuthenticated, isAuthenticating, user, account, logout, isLoggingOut } = useMoralis();

    useEffect(() => {
        if (isAuthenticated) {
            // add your logic here
            // You have logged in as user.get(ethAddress);
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [isAuthenticated]);

    const login = async () => {
        if (!isAuthenticated) {

            await authenticate({ signingMessage: "Log in using your wallet" })
                .then(function (user) {
                    console.log("logged in user:", user.get('ethAddress'));
                    console.log(user.get("ethAddress"));
                })
                .catch(function (error) {
                    console.log(error);
                });
        }
    }

    const logOut = async () => {
        await logout();
        console.log("logged out");
    }


    return (
        <main>

            <div className='landingpage_main'>
                <img className='image_class' src={logo} alt="no image" srcset="" />
                <h2>Welcome to <span className='title'>Flashloan4Good!</span></h2>
                <p>Please click on 'Metamask Login' button to authenticate with your wallet</p>
                {/* <button className='submit' onClick={login}>Metamask Login</button> */}

            </div>
            <div className='landingpage_logout'>
                {/* You have logged in as {user.get(ethAddress)} */}
                {isAuthenticated ? (
                    <>
                        <p>You have authenticated as <span className='username'>{user.getUsername()}</span></p>
                        {/* <p>Your Wallet Address is: {user.get(account[0])}</p> */}
                        <button className='submit' colorScheme="purple" onClick={logout} disabled={isLoggingOut}>Logout</button>
                    </>
                ) : (
                    <button className='submit' onClick={() => authenticate({
                        signingMessage: "Sign to auth on Dashboard"
                    })} disabled={isAuthenticating}>Metamask Login</button>
                )}
            </div>
        </main>
    )
}

export default LandingPage;
