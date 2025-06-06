// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DocumentHasher.sol";
import "./DocumentStorage.sol";
import "./OwnerManager.sol";

contract PDFVerifierMaster is OwnerManager {
    DocumentHasher public hasher;
    DocumentStorage public storageContract;

    event DocumentRegistered(string title, bytes32 hash, uint256 timestamp);

    constructor(address _hasher, address _storageContract) {
        hasher = DocumentHasher(_hasher);
        storageContract = DocumentStorage(_storageContract);
    }

    function registerDocument(string memory title, uint256 size, string memory publicationDate) public onlyOwner {
        bytes32 hash = hasher.computeHash(title, size, publicationDate);
        storageContract.storeDocument(title, hash);
        emit DocumentRegistered(title, hash, block.timestamp);
    }

    function verifyDocument(string memory title, uint256 size, string memory publicationDate) public view returns (bool) {
        bytes32 inputHash = hasher.computeHash(title, size, publicationDate);
        return inputHash == storageContract.getDocumentHash(title);
    }

    function getDocumentTimestamp(string memory title) public view returns (uint256) {
        return storageContract.getDocumentTimestamp(title);
    }
}
