import React, { useState, useEffect } from 'react';
import Web3 from 'web3';
import BlackTea024Contract from './contracts/BlackTea024.json'; // Import your BlackTea024 smart contract ABI
import './App.css';

function App() {
    const [web3, setWeb3] = useState(null);
    const [accounts, setAccounts] = useState([]);
    const [contractInstance, setContractInstance] = useState(null);
    const [tokenId, setTokenId] = useState('');
    const [amount, setAmount] = useState('');
    const [price, setPrice] = useState('');
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        async function initWeb3() {
            if (window.ethereum) {
                const web3Instance = new Web3(window.ethereum);
                try {
                    // Request account access if needed
                    await window.ethereum.enable();
                    setWeb3(web3Instance);
                    const accounts = await web3Instance.eth.getAccounts();
                    setAccounts(accounts);
                    const networkId = await web3Instance.eth.net.getId();
                    const deployedNetwork = BlackTea024Contract.networks[networkId];
                    const contractInstance = new web3Instance.eth.Contract(
                        BlackTea024Contract.abi,
                        deployedNetwork && deployedNetwork.address,
                    );
                    setContractInstance(contractInstance);
                } catch (error) {
                    console.error('Error initializing web3', error);
                }
            }
        }
        initWeb3();
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            await contractInstance.methods.placeBuyOrder(tokenId, amount, price).send({ from: accounts[0] });
            console.log('Buy order placed successfully');
            // Add any addit

