iStarlightSocialAbi =[
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_admin",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "_dashboardFactory",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "createDashboard",
		"outputs": [
			{
				"internalType": "address",
				"name": "_dashboard",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"name": "deposit",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_balance",
				"type": "uint256"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_balance",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getChargeBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_balance",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getDashboard",
		"outputs": [
			{
				"internalType": "address",
				"name": "_dashboard",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMediaEarnings",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "_mediaContentHash",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_shareCount",
				"type": "uint256[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_earnings",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMostShared",
		"outputs": [
			{
				"internalType": "string",
				"name": "_mediaContentHash",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_shareCount",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getRewardBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_balance",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSeasonEnd",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_seasonEnd",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSeasonStart",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_seasonStart",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getShareCurrency",
		"outputs": [
			{
				"internalType": "address",
				"name": "_shareCurrency",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getShareFee",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_fee",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getShareReward",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_shareReward",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getShareStream",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "_mediaContentHash",
				"type": "string[]"
			},
			{
				"internalType": "address[]",
				"name": "_sharedBy",
				"type": "address[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_sharedAt",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "hasDashboard",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_hasDashboard",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_reward",
				"type": "uint256"
			}
		],
		"name": "setRewardFee",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_set",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_fee",
				"type": "uint256"
			}
		],
		"name": "setShareFee",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_set",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_mediaContentHash",
				"type": "string"
			},
			{
				"internalType": "address[]",
				"name": "_friends",
				"type": "address[]"
			}
		],
		"name": "shareMedia",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_friendCount",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"name": "withdraw",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_balance",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]