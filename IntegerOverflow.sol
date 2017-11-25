pragma solidity 0.4.19;

contract SafeMath {

  /**
    Here var maps to a uint8 since that's all that's needed to hold '0'
    This means the loop counter will overflow for any _length greater than 255
   */
  function sneakyLoop(uint256 _length) public returns (uint256) {
    for (var i = 0; i < _length; i++) {
      // Do Some Action
    }
  }
}

