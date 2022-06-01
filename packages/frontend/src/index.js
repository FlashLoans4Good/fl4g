import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from "react-router-dom";
import './index.css';
import App from './App';
import { MoralisProvider } from 'react-moralis';



ReactDOM.render(
  <React.StrictMode>
    <MoralisProvider serverUrl="https://s0pxbzmon9k2.usemoralis.com:2053/server" appId="a9vpG3VBxBerKxxCC2OPvcIkmFwIkTsbNRL3qgky">
      <BrowserRouter>

        <App />
      </BrowserRouter>
    </MoralisProvider>
  </React.StrictMode>,
  document.getElementById('root')
);

