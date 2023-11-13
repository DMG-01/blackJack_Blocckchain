// SPDX-License-Identifier:MIT 
// function forceWithdraw
// set the totalBalance to zero after win
// modify the contract total Balance 
//fund the contract with more than zero ether
 
pragma solidity ^0.8.19;

contract GameStake {
    address[] public stakers;
    mapping(address => uint256) public addressToTotalStake;
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }
    error stakeMustBeGreaterThanZero();
    error onlyOwnerCanCallThisFunction();
    error invalidAmountPassed();

    function depositStake(uint256 _computerStake) external payable returns (uint256) {
        if(msg.value <= 0){
          revert stakeMustBeGreaterThanZero();
        }

        uint256 userStake = msg.value;
        uint256 computerStake = _computerStake;

        address staker = msg.sender;
        stakers.push(staker);

        uint256 totalStake = userStake + computerStake;
        addressToTotalStake[staker] = totalStake;

        return addressToTotalStake[staker];
    }

    function winGame() external {
        for (uint256 userIndex = 0; userIndex < stakers.length; userIndex++) {
            address staker = stakers[userIndex];
            uint256 userTotalStake = addressToTotalStake[staker];
            payable(staker).transfer(userTotalStake);
            addressToTotalStake[staker] = 0;
        }
        

        stakers = new address[](0);
    }

    function loseGame() external {
        for (uint256 userIndex = 0; userIndex < stakers.length; userIndex++) {
            address staker = stakers[userIndex];
          
            addressToTotalStake[staker] = 0;
        }

        stakers = new address[](0);
    }

    function fundContract() external payable {
      if(msg.value <= 0){
        revert invalidAmountPassed();
      }
    }

    function forceWithdraw() public payable  {
    if(msg.sender != owner) {
    revert onlyOwnerCanCallThisFunction();
    }
    uint256 totalBalance = address(this).balance; 
    payable(owner).transfer(totalBalance);
    }


    /**GETTER FUNCTIONS */

    function getTotalStake() public view returns(uint256){
      uint256 totalBalance = addressToTotalStake[msg.sender];
      return(totalBalance);
    }
     
    function getUserAddress() public view returns(address){
      return(msg.sender);
    }
    
    function getUserBalance() public view returns(uint256) {
      uint256 userBalance = msg.sender.balance;
      return(userBalance);
    }


}
