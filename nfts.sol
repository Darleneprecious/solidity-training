// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@5.0.0/access/Ownable.sol";

contract DarleneNFT is ERC721URIStorage, Ownable {
    constructor(address initialOwner) Ownable(initialOwner) ERC721("DarleneNFT", "Darlene") {}

    function mint(
        address _to,
        uint256 _tokenId,
        string calldata _uri
        ) external onlyOwner {
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, _uri);
    }
}