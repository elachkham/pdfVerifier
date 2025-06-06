// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentStorage {
    struct Document {
        bytes32 docHash;
        uint256 timestamp;
    }

    mapping(string => Document) public documents;
    address public master;

    modifier onlyMaster() {
        require(msg.sender == master, "Unauthorized");
        _;
    }

    constructor(address _master) {
        master = _master;
    }

    function setMaster(address newMaster) public onlyMaster {
        require(newMaster != address(0), "Invalid master address");
        master = newMaster;
    }

    function storeDocument(string memory title, bytes32 hash) public onlyMaster {
        documents[title] = Document(hash, block.timestamp);
    }

    function getDocumentHash(string memory title) public view returns (bytes32) {
        return documents[title].docHash;
    }

    function getDocumentTimestamp(string memory title) public view returns (uint256) {
        return documents[title].timestamp;
    }
}
