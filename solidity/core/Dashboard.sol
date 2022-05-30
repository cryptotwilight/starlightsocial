// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/IFriend.sol";
import "../interfaces/IDashboard.sol";


contract Dashboard is IDashboard, IFriend {

    address owner; 
    string avatar; 
    string nickName; 
    address[] friends; 
    mapping(address=>bool) isKnownFriend; 

    string [] media;
    mapping(string=>uint256) uploadDateByMedia; 
    mapping(string=>string) mediaContentHashByTitle; 
    
    constructor(address _owner) {
        owner = _owner; 
    }

    function getAvatar() view external returns (string memory _contentHash){
        return avatar;
    }

    function getNickName() view external returns (string memory _name){
        return nickName; 
    }

    function isFriend(address _friend) view external returns (bool _isFriend){
        return isKnownFriend[_friend];
    }

    function getFriends() view external returns (address [] memory _friends){
        onlyOwner();
        return friends; 
    }

    function addFriend(address _friend) external returns (uint256 _friendCount){
        onlyOwner();
        friends.push(_friend);
        isKnownFriend[_friend] = true; 
        return friends.length; 
    }

    function removeFriend(address _friend) external returns (uint256 _friendCount){
        onlyOwner();
        address [] memory friends_ = new address[](friends.length-1);
        delete isKnownFriend[msg.sender];
        for(uint256 x = 0; x < friends.length; x++){
            address friend_ = friends[x];
            if(friend_ != _friend) { 
                friends[x] = friend_;
            }
        }
        friends = friends_; 
        return friends.length; 
    }

    function getMedia() view external returns (string [] memory _mediaContentHash, uint256 [] memory _uploadDate){
        onlyOwner();
        _uploadDate = new uint256[](media.length);
        for(uint256 x = 0; x < media.length; x++) {
            _uploadDate[x] = uploadDateByMedia[media[x]];
        }
        return (_mediaContentHash, _uploadDate);
    }

    function uploadMedia(string memory _mediaContentHash) external returns (bool _uploaded) {
        onlyOwner();
        media.push(_mediaContentHash);
        uploadDateByMedia[_mediaContentHash] = block.timestamp; 
        return true; 
    }


    function getConvos() view external returns (address [] memory _conversations){
        // @todo conversations
    }


// =================================== INTERNAL =======================================


    function onlyOwner() view internal returns (bool) {
        require(msg.sender == owner, "only owner" );
        return true; 
    }

}