import json

CONTRACT_ABI = json.loads("""[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "insert_time",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "due_date",
				"type": "string"
			},
			{
				"internalType": "int256",
				"name": "money_cost",
				"type": "int256"
			},
			{
				"internalType": "address",
				"name": "buyer_address",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "notes",
				"type": "string"
			}
		],
		"name": "insertFood",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			}
		],
		"name": "joinGroup",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "transfer_time",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "from_address",
				"type": "address"
			},
			{
				"internalType": "int256",
				"name": "amount",
				"type": "int256"
			},
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "notes",
				"type": "string"
			}
		],
		"name": "transfer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "use_food_group_id",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "use_food_address",
				"type": "string"
			},
			{
				"internalType": "int256",
				"name": "use_food_amount_percentage",
				"type": "int256"
			}
		],
		"name": "useFood",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			}
		],
		"name": "getAccountsByGroup",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "addr",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "group_id",
						"type": "string"
					},
					{
						"internalType": "int256",
						"name": "balance",
						"type": "int256"
					}
				],
				"internalType": "struct FoodSharing.Account[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			}
		],
		"name": "getFoodsByGroup",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "insert_time",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "due_date",
						"type": "string"
					},
					{
						"internalType": "int256",
						"name": "money_cost",
						"type": "int256"
					},
					{
						"internalType": "address",
						"name": "buyer_address",
						"type": "address"
					},
					{
						"internalType": "int256",
						"name": "quantity_left_percentage",
						"type": "int256"
					},
					{
						"internalType": "string",
						"name": "food_address",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "simpler_food_address",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "group_id",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "notes",
						"type": "string"
					}
				],
				"internalType": "struct FoodSharing.Food[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			}
		],
		"name": "getTransfersByGroup",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "transfer_time",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "from_address",
						"type": "address"
					},
					{
						"internalType": "address",
						"name": "to_address",
						"type": "address"
					},
					{
						"internalType": "int256",
						"name": "amount",
						"type": "int256"
					},
					{
						"internalType": "string",
						"name": "group_id",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "notes",
						"type": "string"
					}
				],
				"internalType": "struct FoodSharing.TransferRecord[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "groupAccounts",
		"outputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "addr",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			},
			{
				"internalType": "int256",
				"name": "balance",
				"type": "int256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "groupFoods",
		"outputs": [
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "insert_time",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "due_date",
				"type": "string"
			},
			{
				"internalType": "int256",
				"name": "money_cost",
				"type": "int256"
			},
			{
				"internalType": "address",
				"name": "buyer_address",
				"type": "address"
			},
			{
				"internalType": "int256",
				"name": "quantity_left_percentage",
				"type": "int256"
			},
			{
				"internalType": "string",
				"name": "food_address",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "simpler_food_address",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "notes",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "groupTransfers",
		"outputs": [
			{
				"internalType": "string",
				"name": "transfer_time",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "from_address",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to_address",
				"type": "address"
			},
			{
				"internalType": "int256",
				"name": "amount",
				"type": "int256"
			},
			{
				"internalType": "string",
				"name": "group_id",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "notes",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]""")

CONTRACT_ADDRESS = "0x5fbdb2315678afecb367f032d93f642f64180aa3"

CHAIN_URL = "http://localhost:8545/"
