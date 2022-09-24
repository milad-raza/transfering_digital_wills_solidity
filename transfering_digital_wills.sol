// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract TransferringDigitalWills{

    enum assetTypes {
        CASH,
        PROPERTY
    }

    struct assetDetailInfo{
        uint assetType;
        string assetAddressOrAccountNumber;
        uint valueOfAsset;
        bool assetAdded;
    }

    mapping(address => assetDetailInfo) allAssetDetails;

    function addWill(uint assetType, string memory assetAddressOrAccountNumber, uint valueOfAsset) public returns(string memory){
        require(assetType < 2, "You can only choose 0: cash, 1: property");
        require(!allAssetDetails[msg.sender].assetAdded, "Asset already added");
        allAssetDetails[msg.sender] = assetDetailInfo(assetType, assetAddressOrAccountNumber, valueOfAsset, true);
        return "Asset added successfully";
    }

    function updateWill(uint assetType, string memory assetAddressOrAccountNumber, uint valueOfAsset) public returns(string memory){
        require(assetType < 2, "You can only choose 0: cash, 1: property");
        allAssetDetails[msg.sender] = assetDetailInfo(assetType, assetAddressOrAccountNumber, valueOfAsset, true);
        return "Asset updated successfully";
    }

    function getMyWill() public view returns(assetDetailInfo memory){
        require(allAssetDetails[msg.sender].assetAdded, "No asset added againts you");
        return allAssetDetails[msg.sender];
    }

    function transferMyWill(address transferTo) public returns(string memory){
        require(allAssetDetails[msg.sender].assetAdded, "No asset added againts you");
        allAssetDetails[transferTo] = allAssetDetails[msg.sender];
        allAssetDetails[msg.sender] = assetDetailInfo(0, "", 0, false);
        return "Asset transfer successfully";
    }

    function deleteMyWill() public returns(string memory){
        require(allAssetDetails[msg.sender].assetAdded, "No asset added againts you");
        allAssetDetails[msg.sender] = assetDetailInfo(0, "", 0, false);
        return "Asset remove successfully";
    }

    function getWillByAddress(address addressOfUser) public view returns(assetDetailInfo memory){
        require(allAssetDetails[addressOfUser].assetAdded, "No asset added againts this person");
        return allAssetDetails[addressOfUser];
    } 
}