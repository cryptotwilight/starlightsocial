// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IDashboard { 

    function getFriends() view external returns (address [] memory _friends);

    function addFriend(address _friend) external returns (uint256 _friendCount);

    function removeFriend(address _friend) external returns (uint256 _friendCount);

    function getConvos() view external returns (address [] memory _conversations);

    function uploadMedia(string memory _mediaContentHash) external returns (bool _uploaded);

    function getMedia() view external returns (string [] memory _mediaContentHash, uint256 [] memory _uploadDate);

}