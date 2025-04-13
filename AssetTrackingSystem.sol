// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract AssetTrackingSystem {
    struct Asset {
        string name;
        string description;
        string currentLocation;
        uint256 timestamp;
        address[] history;
    }

    mapping(uint256 => Asset) public assets;
    uint256 public assetCount;

    event AssetAdded(uint256 indexed assetId, string name, string description, string currentLocation);
    event LocationUpdated(uint256 indexed assetId, string currentLocation);

    function addAsset(string memory _name, string memory _description, string memory _currentLocation) public {
        assets[assetCount] = Asset({
            name: _name,
            description: _description,
            currentLocation: _currentLocation,
            timestamp: block.timestamp,
            history: new address[](0)
        });
        assets[assetCount].history.push(msg.sender);
        emit AssetAdded(assetCount, _name, _description, _currentLocation);
        assetCount++;
    }

    function updateLocation(uint256 _assetId, string memory _currentLocation) public {
        Asset storage asset = assets[_assetId];
        asset.currentLocation = _currentLocation;
        asset.timestamp = block.timestamp;
        asset.history.push(msg.sender);
        emit LocationUpdated(_assetId, _currentLocation);
    }

    function getAsset(uint256 _assetId) public view returns (string memory, string memory, string memory, uint256, address[] memory) {
        Asset storage asset = assets[_assetId];
        return (asset.name, asset.description, asset.currentLocation, asset.timestamp, asset.history);
    }
}