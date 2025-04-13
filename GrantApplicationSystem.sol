// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract GrantApplicationSystem {
    struct Grant {
        string title;
        string description;
        uint256 amountRequested;
        address applicant;
        bool isApproved;
        bool isFunded;
    }

    mapping(uint256 => Grant) public grants;
    uint256 public grantCount;

    event GrantApplied(uint256 indexed grantId, string title, string description, uint256 amountRequested, address applicant);
    event GrantApproved(uint256 indexed grantId);
    event GrantFunded(uint256 indexed grantId);

    function applyForGrant(string memory _title, string memory _description, uint256 _amountRequested) public {
        grants[grantCount] = Grant({
            title: _title,
            description: _description,
            amountRequested: _amountRequested,
            applicant: msg.sender,
            isApproved: false,
            isFunded: false
        });
        emit GrantApplied(grantCount, _title, _description, _amountRequested, msg.sender);
        grantCount++;
    }

    function approveGrant(uint256 _grantId) public {
        Grant storage grant = grants[_grantId];
        require(!grant.isApproved, "Grant already approved");
        grant.isApproved = true;
        emit GrantApproved(_grantId);
    }

    function fundGrant(uint256 _grantId) public {
        Grant storage grant = grants[_grantId];
        require(grant.isApproved, "Grant not approved");
        require(!grant.isFunded, "Grant already funded");
        grant.isFunded = true;
        emit GrantFunded(_grantId);
    }

    function getGrant(uint256 _grantId) public view returns (string memory, string memory, uint256, address, bool, bool) {
        Grant storage grant = grants[_grantId];
        return (grant.title, grant.description, grant.amountRequested, grant.applicant, grant.isApproved, grant.isFunded);
    }
}