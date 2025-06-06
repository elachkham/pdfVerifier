// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentHasher {
    function computeHash(string memory title, uint256 size, string memory publicationDate)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(title, size, publicationDate));
    }
}
