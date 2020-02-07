from web3 import Web3

infura = "https://mainnet.infura.io/v3/2454c0accfb44468aadb96a6e5c966db"

web3= Web3(Web3.HTTPProvider(infura))

print(web3.isConnected())