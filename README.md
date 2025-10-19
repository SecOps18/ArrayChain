# ArrayChain: Smart Array Operations on Ethereum

A blockchain-based smart contract platform that provides secure and efficient array manipulation operations with ETH-powered functions. This project demonstrates advanced Solidity development, combining data structure operations with blockchain payment features using the Scaffold-ETH 2 framework.

## Features

- **Array Manipulation Functions:**
  - `getFirstN`: Retrieve first N elements from an array
  - `getLastN`: Retrieve last N elements from an array
  - `getAtIndex`: Get element at a specific index
  - `reverseArray`: Reverse the entire array
  - `changeElement`: Update element at a specific index

- **Blockchain Integration:**
  - Implemented using Solidity
  - Uses Foundry for testing and deployment
  - ETH payment functionality for certain operations

## Tech Stack

- Solidity (Smart Contract Development)
- Foundry (Testing & Deployment)
- Next.js (Frontend)
- TypeScript
- Wagmi (Ethereum Hooks)
- RainbowKit (Wallet Connection)

## Project Structure

```
packages/
├── foundry/            # Smart contract development
│   ├── contracts/      # Solidity smart contracts
│   ├── test/          # Contract test files
│   └── script/        # Deployment scripts
└── nextjs/            # Frontend application
    └── app/           # Next.js 13+ app directory
```

## Smart Contract Details

The main smart contract (`YourContract.sol`) implements array manipulation functions with the following features:

- Secure array bounds checking
- ETH payment requirements for certain functions
- Event emission for tracking operations
- Gas-optimized implementations

## Local Development

1. Clone the repository:
```bash
git clone https://github.com/SecOps18/ArrayChain.git
cd ArrayChain
```

2. Install dependencies:
```bash
pnpm install
```

3. Start the local network:
```bash
cd packages/foundry
forge script script/Deploy.s.sol --rpc-url localhost:8545 --broadcast
```

4. Run the frontend:
```bash
cd packages/nextjs
pnpm run dev
```

## Testing

Run smart contract tests:
```bash
cd packages/foundry
forge test
```

## License

This project is licensed under MIT License - see the LICENSE file for details.
