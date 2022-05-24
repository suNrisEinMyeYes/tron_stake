// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Stake is Ownable, ReentrancyGuard{

    using Counters for Counters.Counter;
    Counters.Counter private stakeId;

    event newStake(address stakeHolder, uint256 amount, uint256 startDate, uint256 endDate);

    struct Settings{
        uint256 percentPerMinute;
        uint256[] stakePlans;
        uint256 feeAmount;
        address comissionReceiver;

    }
    
    struct StakeStr{
        uint256 amount;
        uint256 startDate;
        uint256 endDate;
        address owner;
    }

    StakeStr[] stakes;

    Settings settings;

    uint256 totalBalance = 0;

    constructor(uint256 _fee, uint256[] memory _stakePlans, uint256 _percentPerMinute){
        settings.comissionReceiver = msg.sender;
        settings.feeAmount = _fee;
        settings.percentPerMinute = _percentPerMinute;
        settings.stakePlans = _stakePlans;

    }

    function stake(uint256 _timeInMinutes) public payable returns(uint256) {
        require(msg.value > 0, "You can't stake 0 ");
        stakes.push(StakeStr(msg.value, block.timestamp, block.timestamp + _timeInMinutes * 60, msg.sender));
        emit newStake(msg.sender, msg.value, block.timestamp, block.timestamp + _timeInMinutes * 60);
        stakeId.increment();
        totalBalance += msg.value;
        return stakeId.current() - 1;
    }

    function claim(uint256 _stakeId) public nonReentrant{
        require(stakes[_stakeId].endDate < block.timestamp, "Need to wait more time to claim this stake");
        require(stakes[_stakeId].owner == msg.sender, "Permission denied");
        payable(msg.sender).transfer(stakes[_stakeId].amount + stakes[_stakeId].amount * settings.percentPerMinute *(stakes[_stakeId].endDate - stakes[_stakeId].startDate) /100/60 );
        totalBalance -= stakes[_stakeId].amount;
        delete stakes[_stakeId];

        
    }

    function getAllStakeHolders() public view returns(StakeStr[] memory){
        return stakes;
    }

    function getTotalBalance() public view returns(uint256){
        return totalBalance;
    }

    function changeSettings(uint256 _fee, uint256[] memory _stakePlans, uint256 _percentPerMinute, address _comissionReceiver) public onlyOwner{
        settings.comissionReceiver = _comissionReceiver;
        settings.feeAmount = _fee;
        settings.percentPerMinute = _percentPerMinute;
        settings.stakePlans = _stakePlans;

    } 


}