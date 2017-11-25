pragma solidity 0.4.19;

contract DataValidation {

  uint256 public totalSupply = 10000000000;
  uint public dailyLimit = 5 ether;
  mapping (address => uint256) public balances;

  function send(uint256 _amount) public {
    require(_amount < balances[msg.sender]);
    require(_amount < dailyLimit);
    // Send the funds
  }

  // Stolen from Consensys Smart Contract Best Practices
  function deposit(uint256 _amount) public payable {
    balances[msg.sender] += msg.value;
    totalSupply += msg.value;
    assert(this.balance >= totalSupply);
  }
}
