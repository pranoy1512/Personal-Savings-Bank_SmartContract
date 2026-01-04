# PersonalSavingsBank Contract - Ownership Logic

## Overview
This smart contract implements a personal savings bank where users can deposit ETH and only the contract owner can manage and view sensitive information.

## Ownership Implementation

### 🏆 **Owner Assignment**
- The contract deployer becomes the permanent owner during contract creation
- Ownership is set in the constructor and **cannot be transferred**
- Implemented via: `owner = msg.sender` in constructor

### 🔐 **Owner-Only Functions**

| Function | Purpose | Access Control |
|----------|---------|----------------|
| `withdraw()` | Withdraw ETH from contract | `require(msg.sender == owner)` |
| `getBalance()` | View contract balance | `require(msg.sender == owner)` |
| `getSender()` | View user deposit details | `require(msg.sender == owner)` |

### 📊 **Access Control Summary**

| User Type | Permissions |
|-----------|-------------|
| **Owner** | - Withdraw ETH<br>- View total balance<br>- Access all user details<br>- Set name on first deposit |
| **Regular Users** | - Deposit ETH with name<br>- Update deposit amount<br>- Name can only be set once |
