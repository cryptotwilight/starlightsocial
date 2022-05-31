iDashboardFactoryAbi = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			}
		],
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
				"internalType": "string",
				"name": "_nickname",
				"type": "string"
			}
		],
		"name": "findDashboard",
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
		"inputs": [
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			}
		],
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
		"inputs": [
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			}
		],
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
				"internalType": "address",
				"name": "_dashboard",
				"type": "address"
			}
		],
		"name": "isKnownDashboard",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_knownDashboard",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_nickname",
				"type": "string"
			}
		],
		"name": "updateNickname",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_updated",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]