iDashboardAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_friend",
				"type": "string"
			}
		],
		"name": "addFriend",
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
		"inputs": [],
		"name": "getConvos",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_conversations",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getFriends",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_friends",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMedia",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "_mediaContentHash",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uploadDate",
				"type": "uint256[]"
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
		"inputs": [
			{
				"internalType": "string",
				"name": "_friend",
				"type": "string"
			}
		],
		"name": "removeFriend",
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
				"internalType": "string",
				"name": "_mediaContentHash",
				"type": "string"
			}
		],
		"name": "uploadMedia",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_uploaded",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]