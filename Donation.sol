//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract charityDonation{
    address public immutable owner;
    string public  cause;
    uint public goal;
    uint public minContribution;
    uint public maxContribution;
    uint public totalFunds;

    

    event Donation( address indexed Donator, uint  amount, string cause);
    event withdrawal (address indexed owner, uint amount);

   

    modifier onlyOwner (){
        require(msg.sender == owner, "you are not the owner");
        _;
    }

    
    constructor( 
        string memory _cause, 
        uint _goal, 
        uint _minContribution, 
        uint _maxContribution 
    ) {
        owner = msg.sender;
        goal = _goal;
        cause = _cause;
        minContribution = _minContribution;
        maxContribution = _maxContribution;
    }



    function Donate() external payable {
        require(msg.value >= minContribution && msg.value <= maxContribution, "Your value is not within the limit");
        require(totalFunds + msg.value <= goal, "goal already reached");

        totalFunds += msg.value; 
        emit Donation(msg.sender,  msg.value, cause);

         

        

    }

    function withdraw() external onlyOwner{
        require(totalFunds >= goal, "goal has not been reached");
        uint256 withdrawalAmount = totalFunds;
        totalFunds = 0;

        payable(owner).transfer(withdrawalAmount);

        emit withdrawal(owner, withdrawalAmount);


    }

    function getDonationBalance()external view returns (uint256){
      return address(this).balance;  
    }


}