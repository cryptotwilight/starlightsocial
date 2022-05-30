// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IStarlightSocial { 

    function getShareFee() view external returns (uint256 _fee);

    function getShareCurrency() view external returns (address _shareCurrency);

    function getMediaEarnings() view external returns (string [] memory _mediaContentHash, uint256 [] memory _shareCount, uint256 [] memory _earnings);

    function getBalance() view external returns (uint256 _balance);

    function deposit(uint256 _chargeAmount) payable external returns (uint256 _balance);

    function withdraw(uint256 _withdrawAmount) external returns (uint256 _balance);

}