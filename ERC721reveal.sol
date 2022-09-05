//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ObscuraNFT is ERC721URIStorage, Ownable {
    using Strings for uint256;
    uint256 private tokenId = 0;
    uint256 private price;
    string private uri;
    bool public isRevealed = false;
    string private baseExtension = ".json";

    event mintToken(address _minter, uint256 _tokenId);
    event revealNft(bool isReveal);
    event mintPrice(uint256 _price);
    event setTokenURI(string _tokenUri);

    constructor() ERC721("OBSCURA NFT", "OBS") {
        setURI("ipfs://Qmcy1xyAYfnqsCMbBHbVWD8UfrWY193vZGaEpghfDZvuWG/");
    }

    /**
     * @dev setting nft price
     * @param _price NFT price
     */

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
        emit mintPrice(price);
    }

    function mintingPrice() public view returns (uint256) {
        return price;
    }

    /**
     * @dev setting base uri
     * @param _uri NFT URI
     */

    function setURI(string memory _uri) public onlyOwner {
        uri = _uri;
        emit setTokenURI(uri);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return uri;
    }

    /**
     * @dev reveal BaseURI
     */

    function reveal() public onlyOwner {
        isRevealed = true;
        emit revealNft(isRevealed);
    }

    /**
     * @dev tokenId for minting
     * @param _tokenId gets (random) tokenId to mint
     */

    function mint(uint256 _tokenId) external payable {
        require(msg.value == price, "0x0");
        require(tokenId <= 60);
        tokenId++;
        _mint(msg.sender, _tokenId);
        emit mintToken(msg.sender, _tokenId);
    }

    function totalSupply() public view returns (uint256) {
        return tokenId;
    }

    /**
     * @dev get tokenURI before and after revealation
     */

    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(_tokenId), "0x0");

        string memory currentBaseURI = _baseURI();

        if (isRevealed == false) {
            return
                string(
                    abi.encodePacked(
                        "ipfs://QmV78tXqchZFa6ogQPjW31no4S9dSdMZwoW8bE3vMpQZSP"
                    )
                );
        }

        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        _tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }
}