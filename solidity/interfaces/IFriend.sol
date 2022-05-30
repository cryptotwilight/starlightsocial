// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IFriend { 

    function getAvatar() view external returns (string memory _contentHash);

    function getNickName() view external returns (string memory _name);

    function isFriend(address _friend) view external returns (bool _isFriend);
}