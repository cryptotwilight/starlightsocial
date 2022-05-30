// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/fcf35e5722847f5eadaaee052968a8a54d03622a/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import "../interfaces/IDashboardFactory.sol";
import "../interfaces/IStarlightSocial.sol";
import "../interfaces/IFriend.sol";
import "../interfaces/StakingInterface.sol";

contract StarlightSocial is IStarlightSocial {

    uint256 MONTH = 30*24*60*60; 

    uint256 RELEASE_PERIOD = 7 * 24 * 60 * 60; 

    address self; 

    uint256 minimumViralShareCount = 10; 

    uint256 shareReward = 10000000000000; //$0.1 per share ; 

    enum ShareType {SHARE, RESHARE}

    address administrator; 

    IDashboardFactory factory; 
    
    address stakingPrecompileAddress = 0x0000000000000000000000000000000000000800; 

    ParachainStaking stakingInterface = ParachainStaking(stakingPrecompileAddress); 

    uint256 shareFee = 10000000000000000; 
    address shareCurrency;

    uint256 SEASON = 0; 

    uint256 seasonStart; 
    uint256 seasonEnd; 

    bool seasonStarted; 
    bool seasonEnded; 

    uint256 poolBalance; 
    uint256 exitBalance; 

    mapping(address=>uint256) chargeBalanceByAddress; 
    mapping(address=>uint256) rewardBalanceByAddress; 

    mapping(string=>uint256) shareCountByMediaContentHash; 


    mapping(address=>string[]) shareStreamByAddress;
    mapping(address=>mapping(string=>bool)) shareSeenByAddress;  

    mapping(string=>bool) knownMediaContentHash;

    mapping(string=>address) ownerByMediaContentHash; 
    mapping(string=>uint256) shareAtByMediaContentHash;

    mapping(address=>string[]) sharesByOwner;

    mapping(uint256=>mapping(address=>uint256)) newSharesByAddressBySeason; 
    mapping(string=>uint256) earningsByShare; 


    constructor(address _admin, address _dashboardFactory) {
        administrator = _admin; 
        self = payable(address(this));
        factory = IDashboardFactory(_dashboardFactory);
    }

    function getSeasonStart() view external returns (uint256 _seasonStart) {
        return seasonStart; 
    }

    function getSeasonEnd() view external returns (uint256 _seasonEnd) {
        return seasonEnd; 
    }

    function getShareReward() view external returns (uint256 _shareReward) {
        return shareReward;
    }

    function getShareFee() view external returns (uint256 _fee){
        return shareFee;
    }

    function getShareCurrency() view external returns (address _shareCurrency){
        return shareCurrency; 
    }

    function getDashboard() view external returns (address _dashboard) {
        return factory.getDashboard(msg.sender);
    }

    function hasDashboard() view external returns (bool _hasDashboard) {
        return factory.hasDashboard(msg.sender);
    }

    function createDashboard() external returns (address _dashboard) {
        return factory.createDashboard(msg.sender);
    }

    function getMediaEarnings() view external returns (string [] memory _mediaContentHash, uint256 [] memory _shareCount, uint256 [] memory _earnings){
        _mediaContentHash = sharesByOwner[msg.sender];
        _shareCount = new uint256[](_mediaContentHash.length);
        _earnings = new uint256[](_mediaContentHash.length);
        for(uint256 x = 0; x < _shareCount.length; x++){
            string memory mediaContentHash_ = _mediaContentHash[x];
            _shareCount[x] = shareCountByMediaContentHash[mediaContentHash_];
            _earnings[x] = earningsByShare[mediaContentHash_];
        }
        return (_mediaContentHash, _shareCount, _earnings);
    }

    function getShareStream() view external returns (string [] memory _mediaContentHash, address [] memory _sharedBy, uint256 [] memory _sharedAt){
        _mediaContentHash = shareStreamByAddress[msg.sender];
        _sharedBy = new address[](_mediaContentHash.length);
        for(uint256 x = 0; x < _sharedBy.length; x++) {
            string memory mediaContentHash_ = _mediaContentHash[x]; 
            _sharedBy[x] = ownerByMediaContentHash[mediaContentHash_];
            _sharedAt[x] = shareAtByMediaContentHash[mediaContentHash_]; 
        }
        return (_mediaContentHash, _sharedBy, _sharedAt);
    }

    function shareMedia(string memory _mediaContentHash, address [] memory _friends) external returns (uint256 _friendCount){
    
        if(knownMediaContentHash[_mediaContentHash]){
            chargeShareFee(ShareType.RESHARE, _mediaContentHash); 
        }
        else {
            knownMediaContentHash[_mediaContentHash] = true; 
            chargeShareFee(ShareType.SHARE, _mediaContentHash); 
            shareAtByMediaContentHash[_mediaContentHash] = block.timestamp;
            ownerByMediaContentHash[_mediaContentHash] = msg.sender;
            sharesByOwner[msg.sender].push(_mediaContentHash);
        }
        for(uint256 x = 0; x < _friends.length; x++) {
            address friend_ = _friends[x];
            IFriend iFriend_ = IFriend(friend_);
            if(iFriend_.isFriend(msg.sender) && !shareSeenByAddress[friend_][_mediaContentHash]){
                _friendCount++;
                shareStreamByAddress[friend_].push(_mediaContentHash); 
            }
        }
        newSharesByAddressBySeason[SEASON][msg.sender] += _friendCount;
    }

    function getBalance() view external returns (uint256 _balance) { 
        return totalBalance();
    }

    function deposit(uint256 _amount) payable external returns (uint256 _balance){
        require(checkSeason()," still in release period "); 
        require(msg.value >= _amount, " amount sent does not equal amount declared ");
        
        chargeBalanceByAddress[msg.sender] += _amount; 
        poolBalance += _amount; 
         // user precompile to add to protocol stake 
        stake();
        return totalBalance(); 
    } 

    function withdraw(uint256 _amount) external returns (uint256 _balance){
        require(seasonEnded, " mid season withdraws not allowed ");
        unstake();
        require(exitCompleted, " exit still pending ");
        // calculate user balance 
        uint256 totalBalance_ = totalBalance(); 
        require(totalBalance_ >= _amount, " insufficient funds for withdrawal ");

        // withdraw from protocol stake 
        require(self.balance >= _amount, " insufficient starlight social balance ");
        decrementTotalBalance(_amount);
        payable(msg.sender).transfer(_amount);

        return totalBalance(); 
    }

    function setShareFee(uint256 _fee) external returns(bool _set) {
        adminOnly();
        require(shareReward < _fee, " share fee too low ");
        shareFee = _fee; 
        return true; 
    }

    function setRewardFee(uint256 _reward)  external returns (bool _set) {
        adminOnly();
        require(_reward < shareFee, " reward fee too high ");
        shareReward = _reward;
        return true;  
    }
 
    // ============================== INTERNAL =====================================

    function decrementTotalBalance(uint256 _amount) internal  {
        uint256 rewards_ = rewardBalanceByAddress[msg.sender];
        if(rewards_ >= _amount) {
             rewardBalanceByAddress[msg.sender] -= _amount; 
        }
        else { 
            rewardBalanceByAddress[msg.sender] -= rewards_;  
            uint256 remainder_ = _amount - rewards_; 
            chargeBalanceByAddress[msg.sender] -= remainder_; 
        }
    }

    function stake() internal returns (bool) {
        if(poolBalance > stakingInterface.min_delegation()) {
            uint256 delegationBalance_ = poolBalance; 
            poolBalance -= delegationBalance_; 
            (uint256 candidateDelegationCount_, address candidate_) = getCandidate();
            uint256 starlightSocialDelegationCount = stakingInterface.delegator_delegation_count(self); 
            stakingInterface.delegate(candidate_, delegationBalance_, candidateDelegationCount_, starlightSocialDelegationCount );
        }
        return true; 
    }

    uint256 exitStart; 
    bool exitStarted; 
    bool exitCompleted; 

    function unstake() internal returns (bool) {
        if(seasonEnded && !exitStarted) {
            stakingInterface.schedule_leave_delegators();
            exitStarted = true; 
            exitStart = block.timestamp; 
            return true; 
        }

        if(exitStarted) {
            if(!stakingInterface.delegator_exit_is_pending(self)){
                stakingInterface.execute_leave_delegators(self, stakingInterface.delegator_delegation_count(self));
                exitCompleted = true; 
                return true; 
            }
        }

        return true; 
    }

    function getCandidate() view internal returns (uint256 _candidateDelegattionCount, address _candidate){
        address [] memory _selectedCandidates = stakingInterface.selected_candidates();
        _candidate = _selectedCandidates[0];
        _candidateDelegattionCount = stakingInterface.candidate_delegation_count(_candidate);
        return (_candidateDelegattionCount, _candidate);
    }

    function chargeShareFee(ShareType _shareType, string memory _mediaContentHash)  internal returns (bool _feePaid) {
        // deduct one dollar from the user's account 
        uint256 sharerBalance_ = chargeBalanceByAddress[msg.sender];

        require(sharerBalance_ > shareFee, "insufficient balance");
        sharerBalance_ -= shareFee; 
        chargeBalanceByAddress[msg.sender] = sharerBalance_;

        // if reshare pay the owner the reward rate 
        if(_shareType == ShareType.RESHARE) {
            rewardBalanceByAddress[ownerByMediaContentHash[_mediaContentHash]] += shareReward;
        }
        return true; 
    }

    function checkSeason() internal returns (bool) {
       if(!seasonStarted && block.timestamp >= seasonStart) { 
            seasonStarted = true; 
            seasonEnded = false; 
            seasonStart = block.timestamp; 
            seasonEnd = seasonStart + MONTH; 
            SEASON ++; 
            
            return true; 
        }
        if(seasonStarted && block.timestamp >= seasonEnd) {
            seasonStarted = false;
            seasonEnded = true;  
            seasonStart = block.timestamp + RELEASE_PERIOD; // start of new season
        }
        return false; 
        
    }

    function totalBalance() view internal returns (uint256 _balance){
        return chargeBalanceByAddress[msg.sender] + rewardBalanceByAddress[msg.sender];
    }

    function adminOnly() view internal returns (bool) {
        require(msg.sender == administrator, " admin only ");
        return true; 
    }
}