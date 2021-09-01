const wrapProvider = require('arb-ethers-web3-bridge').wrapProvider
const HDWalletProvider = require('@truffle/hdwallet-provider')
const mnemonic = ''

module.exports = {
    networks: {
        arbitrum: {
            provider: function () {
                return wrapProvider(
                    new HDWalletProvider(mnemonic, 'https://arb1.arbitrum.io/rpc')
                )
            },
            network_id: '*',
            gasPrice: 0,
        },
        rinkeby_arbitrum: {
            provider: function () {
                return wrapProvider(
                    new HDWalletProvider(mnemonic, 'https://rinkeby.arbitrum.io/rpc')
                )
            },
            network_id: '421611',
            gasPrice: 0,
            gas: 1000000000,
            networkCheckTimeout: 7500
        },
    },
    compilers: {
        solc: {
            version: '0.6.12',
            settings: {
                optimizer: {
                    enabled: true,
                    runs: 200,
                },
            },
        },
    },
}
