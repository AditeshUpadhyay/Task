// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CreditSystem {
    mapping(address => uint256) private balances;
    mapping(address => bool) private initialized;
    address private owner;

   // event Transfer(address indexed from, address indexed to, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function initializeAccount() external {
        require(!initialized[msg.sender], "Account has already been initialized");
        balances[msg.sender] = 1000;
        initialized[msg.sender] = true;
    }

    function getBalance(address account) external view returns (uint256) {
        if (!initialized[account]) {
            return 0;
        }
        return balances[account];
    }

    function transferCredits(address recipient, uint256 amount) external {
        if (!initialized[msg.sender]) {
           // initializeAccount();
           initialized[msg.sender]=true;
           balances[msg.sender] += 1000;
        }
        require(balances[msg.sender] >= amount, "Insufficient credits");
        balances[msg.sender] -= amount;
        if(initialized[recipient]==false){
            balances[recipient]+=1000;
            initialized[recipient]=true;
        }
        balances[recipient] += amount;
      //  emit Transfer(msg.sender, recipient, amount);
    }

    function mintCredits(address account, uint256 amount) external onlyOwner {
        balances[account] += amount;
    }
}
