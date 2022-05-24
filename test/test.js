const chai = require('chai');
const TronGrid = require('trongrid');
const TronWeb = require('tronweb');
const assert = require("assert")
const {bytecode, interface} = require("../build/contracts/Stake.json")


const tronWeb = new TronWeb({
    fullHost: 'https://api.shasta.trongrid.io'
});

const HttpProvider = TronWeb.providers.HttpProvider;


