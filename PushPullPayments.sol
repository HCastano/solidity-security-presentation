pragma solidity 0.4.19;

contract PushPullPayments {

  struct Attendee {
    bool paidDeposit;
    bool gotRefund;
  }

  mapping(address => Attendee) public attendees;

  function giveToPoorFriend(address _to, uint256 _amount) public {
    require(msg.sender.balance > _to.balance);
    require(msg.sender.balance >= _amount);
    _to.transfer(_amount); // If this fails, it will throw
    // Or 
    _to.send(_amount); // If this fails, it will return false
  }

  // This is a bad idea
  function refundAll() public {
    // Pretend I have a list of attendees
    for (uint i = 0; i < attendees.length; i++) {
      if (attendees[i].attended) {
        // Refund the amount they deposited
        attendees[i].send(attendees.deposit);
      }
    }
  }

  // In our case, this is the better way
  function widthdraw() external {
    Attendee attendee = attendees[msg.sender];

    require(!attendee.gotRefund);
    require(attendee.paidDeposit);

    attendee.gotRefund = true;
    bool success = msg.sender.send(attendee.deposit);
    if (!success) {
      attendee.gotRefund = false;
    }
  }
}
