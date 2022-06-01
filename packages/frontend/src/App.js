import { React, useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";

import './App.css';

import { useMoralis } from "react-moralis";
import Home from './components/landingpage/LandingPage';

import Header from './components/header/Header';
import Hero from './components/hero/Hero';
import History from './components/history/History';


function App() {

  return (
    <div>
      <Routes>
        <Route path='/' element={<Home />} />

      </Routes>
      <Header />
      <Hero />
      <History />

    </div>
  );
}

export default App;