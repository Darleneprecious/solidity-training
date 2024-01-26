// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DonationContract {
    address public owner;
    uint256 public withdrawalTime;
    uint256 public minimumContribution;

    mapping(address => uint256) public contributions;

    event ContributionReceived(address contributor, uint256 amount);
    event WithdrawalRequested(address owner, uint256 amount);
    event WithdrawalProcessed(address owner, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not the owner");
        _;
    }

    constructor(uint256 _withdrawalTime, uint256 _minimumContribution) {
        owner = msg.sender;
        withdrawalTime = _withdrawalTime;
        minimumContribution = _minimumContribution;
    }

    function contribute() external payable {
        require(msg.value >= minimumContribution, "Contribution is below the minimum requirement");
        
        contributions[msg.sender] += msg.value;
        emit ContributionReceived(msg.sender, msg.value);
    }

    function requestWithdrawal() external onlyOwner {
        require(block.timestamp >= withdrawalTime, "Withdrawal time has not arrived yet");
        require(address(this).balance > 0, "Not enough funds in the contract");

        uint256 amountToWithdraw = address(this).balance;
        payable(owner).transfer(amountToWithdraw);
        
        emit WithdrawalRequested(owner, amountToWithdraw);
        emit WithdrawalProcessed(owner, amountToWithdraw);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getContribution(address contributor) public view returns (uint256) {
        return contributions[contributor];
    }
}
