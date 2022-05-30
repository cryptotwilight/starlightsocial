// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Dashboard.sol";
import "../interfaces/IDashboardFactory.sol";


contract DashboardFactory is IDashboardFactory { 

    address administrator; 
    address starlightSocialAddress; 

    address [] dashboards; 

    mapping(address=>bool) knownDashboard;
    mapping(address=>bool) hasDashboardAddress;
    mapping(address=>address) dashboardByOwner;

    constructor(address _administrator) {
        administrator = _administrator;
    }

    function getDashboards() view external returns (address[] memory _dashboards) {
        return dashboards; 
    }

    function getDashboard(address _owner) view external returns (address _dashboard){
        if(hasDashboardAddress[_owner]) {
            return dashboardByOwner[_owner];
        }
        return address(0);
    }

    function hasDashboard(address _owner) view external returns(bool _hasDashboard) {
        return hasDashboardAddress[_owner];
    }

    function createDashboard(address _owner) external returns (address _dashboardAddreess) {
        onlySS(); 
        if(hasDashboardAddress[_owner]) {
            return dashboardByOwner[_owner];
        }
        IDashboard dashboard_ = new Dashboard(_owner);
        address dashboardAddress_ = address(dashboard_);
        
        hasDashboardAddress[_owner] = true; 
        knownDashboard[dashboardAddress_] = true;
        dashboardByOwner[_owner] = dashboardAddress_;
        
        dashboards.push(dashboardAddress_);
        return dashboardAddress_; 

    }

    function isKnownDashboard(address _address) view external returns (bool _isKnown) {
        return knownDashboard[_address];
    }

    function setStarlightSocial(address ss)  external returns (bool _set) {
        adminOnly(); 
        starlightSocialAddress = ss; 
        return true; 
    }


    //=================================== INTERNAL ============================================

    function onlySS() view internal returns (bool) {
        require(msg.sender == starlightSocialAddress, " star light social only ");
        return true; 
    }

    function adminOnly() view internal returns (bool) {
        require(msg.sender == administrator, " admin only ");
        return true; 
    }
}