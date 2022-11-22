//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./DefaultOperatorFilterer.sol";

contract ObscuraNFT is ERC721URIStorage, Ownable, DefaultOperatorFilterer {
    //Declarations
    using Strings for uint256;
    uint256 private tokenId = 0;
    string private uri;
    string private mokeupUri;
    bool public isRevealed = false;
    bool public isPublic = false;
    bool public mintPause;
    uint256 public nftCount;
    uint256 public perAddr;
    string private baseExtension = ".json";
    //Mapping
    mapping(address => bool) public blackListAddress;
    mapping(address => bool) public whiteListAddress;
    mapping(address => uint256) public perAddrress;
    //Events
    event mintToken(address _minter, uint256 _tokenId);
    event revealNft(bool _isReveal);
    event isPublicMint(bool _isPublic);
    event mintPrice(uint256 _price);
    event setBaseURI(string _tokenUri);
    event setMokeupURI(string _tokenUri);
    event pauseStatus(bool _mintPause);
    event perNFTStatus(uint256 _perAddress);
    event AddBlackListBulk(address[] _addresses);
    event RemoveBlackListBulk(address[] _addresses);
    event AddWhiteListBulk(address[] _addresses);
    event RemoveWhiteListBulk(address[] _addresses);
    event AddBlackList(address _addresses);
    event RemoveBlackList(address _addresses);
    event AddWhiteList(address _addresses);
    event RemoveWhiteList(address _addresses);

    constructor(
        string memory _uri,
        string memory _mokeupUri,
        uint256 _limitPerAddr
    ) ERC721("OBSCURA NFT", "OBS") {
        uri = _uri;
        mokeupUri = _mokeupUri;
        perAddr = _limitPerAddr;
        mintPause = false;
    }

    /**
     * @dev setting setnormalURI
     * @param _uri Uri
     */

    function setURI(string memory _uri) public onlyOwner {
        uri = _uri;
        emit setBaseURI(uri);
    }

    /**
     * @dev setting setMockupURI
     * @param _uri Uri
     */

    function setMockupURI(string memory _uri) public onlyOwner {
        mokeupUri = _uri;
        emit setMokeupURI(mokeupUri);
    }

    /**
     * @dev setting _baseURI
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return uri;
    }

    /**
     * @dev reveal BaseURI
     */

    function reveal(bool _revealStatus) public onlyOwner {
        isRevealed = _revealStatus;
        emit revealNft(isRevealed);
    }

    /**
     * @dev  setting PublicMint
     */

    function setPublicMint(bool _isPublic) public onlyOwner {
        isPublic = _isPublic;
        emit isPublicMint(isPublic);
    }

    /**
     * @dev  setting pauseMint
     */

    function pauseMint(bool _pauseMint) public onlyOwner {
        mintPause = _pauseMint;
        emit pauseStatus(mintPause);
    }

    /**
     * @dev setting nftPerAddress
     */

    function nftPerAddress(uint256 _peraddr) public onlyOwner {
        perAddr = _peraddr;
        emit pauseStatus(mintPause);
    }

    /**
     * @dev tokenId for minting
     * @param _tokenId gets (random) tokenId to mint
     */

    function mint(uint256 _tokenId) external payable {
        require(mintPause, "0x00");
        require(!blackListAddress[msg.sender], "0x01");
        require(tokenId <= 60, "0x02");
        perAddrress[msg.sender]++;
        require(perAddrress[msg.sender] <= perAddr, "0x3");

        if (isPublic) {
            tokenId++;
            _mint(msg.sender, _tokenId);
        } else {
            require(whiteListAddress[msg.sender], "0x4");
            tokenId++;
            _mint(msg.sender, _tokenId);
        }

        emit mintToken(msg.sender, _tokenId);
    }

    /**
     * @dev returns total supply of NFT
     */

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
        require(_exists(_tokenId), "0x5");

        string memory currentBaseURI = _baseURI();

        if (isRevealed == false) {
            return string(abi.encodePacked(mokeupUri));
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

    /**
     * @dev adding addBlacklistBulk
     */

    function addBlacklistBulk(address[] memory _addresses) public onlyOwner {
        for (uint256 i; i < _addresses.length; i++) {
            blackListAddress[_addresses[i]] = true;
        }
        emit AddBlackListBulk(_addresses);
    }

    /**
     * @dev  adding addWhitelistBulk
     */
    function addWhitelistBulk(address[] memory _addresses) public onlyOwner {
        for (uint256 i; i < _addresses.length; i++) {
            whiteListAddress[_addresses[i]] = true;
        }
        emit AddWhiteListBulk(_addresses);
    }

    /**
     * @dev removing removeBlacklistBulk
     */

    function removeBlacklistBulk(address[] memory addresses) public onlyOwner {
        for (uint256 i; i < addresses.length; i++) {
            blackListAddress[addresses[i]] = false;
        }
        emit RemoveBlackListBulk(addresses);
    }

    /**
     * @dev removing removeWhitelistBulk
     */
    function removeWhitelistBulk(address[] memory _addresses) public onlyOwner {
        for (uint256 i; i < _addresses.length; i++) {
            whiteListAddress[_addresses[i]] = false;
        }
        emit RemoveWhiteListBulk(_addresses);
    }

    /**
     * @dev adding addBlacklist
     */

    function addBlacklist(address _addresses) public onlyOwner {
        blackListAddress[_addresses] = true;

        emit AddBlackList(_addresses);
    }

    /**
     * @dev adding  addWhitelist
     */

    function addWhitelist(address _addresses) public onlyOwner {
        whiteListAddress[_addresses] = true;

        emit AddWhiteList(_addresses);
    }

    /**
     * @dev removing  removeBlacklistBulk
     */

    function removeBlacklist(address _addresses) public onlyOwner {
        blackListAddress[_addresses] = false;

        emit RemoveBlackList(_addresses);
    }

    /**
     * @dev removing removeWhitelistBulk
     */

    function removeWhitelistBulk(address _addresses) public onlyOwner {
        whiteListAddress[_addresses] = false;

        emit RemoveWhiteList(_addresses);
    }


    function transferFrom(address from, address to, uint256 _tokenId) public override onlyAllowedOperator {
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 _tokenId) public override onlyAllowedOperator {
        super.safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 _tokenId, bytes memory data)
        public
        override
        onlyAllowedOperator
    {
        super.safeTransferFrom(from, to, tokenId, data);
    }
}
