// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IDashboardFactory { 

    function hasDashboard(address _owner) view external returns (bool _hasDashboard);

    function getDashboard(address _owner) view external returns (address _dashboard);

    function isKnownDashboard(address _dashboard) view external returns (bool _knownDashboard);

    function createDashboard(address _owner) external returns (address _dashboard);
    
}