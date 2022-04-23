// SPDX-License-Identifier: GPL-3.0

/// @title The Nouns ERC-721 token

/*********************************
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░█████████░░█████████░░░ *
 * ░░░░░░██░░░████░░██░░░████░░░ *
 * ░░██████░░░████████░░░████░░░ *
 * ░░██░░██░░░████░░██░░░████░░░ *
 * ░░██░░██░░░████░░██░░░████░░░ *
 * ░░░░░░█████████░░█████████░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 *********************************/

pragma solidity ^0.8.6;

// @CO2CULT Names are adapted to the CO2CULT context
import { Ownable } from '@openzeppelin/contracts/access/Ownable.sol';
import { ERC721Checkpointable } from './base/ERC721Checkpointable.sol';
import { ICO2OrbsDescriptor } from './interfaces/ICO2OrbsDescriptor.sol';// @CO2CULT Note interfaces have not yet been coded for CO2CULT.
//import { ICO2OrbsSeeder } from './interfaces/ICO2OrbsSeeder.sol'; // @CO2CULT Seeds are not needed.
import { ICO2OrbsToken } from './interfaces/ICO2OrbsToken.sol';// @CO2CULT Note interfaces have not yet been coded for CO2CULT.
import { ERC721 } from './base/ERC721.sol';
import { IERC721 } from '@openzeppelin/contracts/token/ERC721/IERC721.sol';
import { IProxyRegistry } from './external/opensea/IProxyRegistry.sol';

contract CO2OrbsToken is ICO2OrbsToken, Ownable, ERC721Checkpointable {
    // The nounders DAO address (creators org)
    // @CO2CULT Names are adapted to the CO2CULT context
    address public CO2CULTDAO;

    // An address who has permissions to mint Nouns
    address public minter;

    // The Nouns token URI descriptor
    // @CO2CULT Names are adapted to the CO2CULT context
    ICO2OrbsDescriptor public descriptor;

    // The Nouns token seeder
    //  @CO2CULT Seeds are not needed.
    //ICO2OrbsSeeder public seeder;

    // Whether the minter can be updated
    bool public isMinterLocked;

    // Whether the descriptor can be updated
    bool public isDescriptorLocked;

    // Whether the seeder can be updated
    // @CO2CULT Seeds are not needed.
    //bool public isSeederLocked;

    // The noun seeds
    // @CO2CULT Seeds are not needed.
    //mapping(uint256 => ICO2OrbSeeder.Seed) public seeds;

    // The internal noun ID tracker
    // @CO2CULT Names are adapted to the CO2CULT context
    uint256 private _currentCO2OrbId;

    // IPFS content hash of contract-level metadata
    string private _contractURIHash = 'QmZi1n79FqWt2tTLwCqiy6nLM6xLGRsEPQ5JmReJQKNNzX';

    // OpenSea's Proxy Registry
    IProxyRegistry public immutable proxyRegistry;

    /**
     * @notice Require that the minter has not been locked.
     */
    modifier whenMinterNotLocked() {
        require(!isMinterLocked, 'Minter is locked');
        _;
    }

    /**
     * @notice Require that the descriptor has not been locked.
     */
    modifier whenDescriptorNotLocked() {
        require(!isDescriptorLocked, 'Descriptor is locked');
        _;
    }

    /**
     * @notice Require that the seeder has not been locked.
     * @CO2CULT Modifier not necessary as seeder is not removed.
     */
    /*
    modifier whenSeederNotLocked() {
        require(!isSeederLocked, 'Seeder is locked');
        _;
    }
    */

    /**
     * @notice Require that the sender is the nounders DAO.
     * @CO2CULT Names are adapted to the CO2CULT context.
     */
    modifier onlyCO2CULTDAO() {
        require(msg.sender == CO2CULTDAO, 'Sender is not the CO2CULT DAO');
        _;
    }

    /**
     * @notice Require that the sender is the minter.
     */
    modifier onlyMinter() {
        require(msg.sender == minter, 'Sender is not the minter');
        _;
    }

    // @CO2CULT Names are adapted to the CO2CULT context
    constructor(
        address _CO2CULTDAO,
        address _minter,
        INounsDescriptor _descriptor,
        //INounsSeeder _seeder,//  @CO2CULT Seeder not necessary for CO2CULT purposes.
        IProxyRegistry _proxyRegistry
    ) ERC721('CO2Orbs', 'CO2ORB') {
        CO2CULTDAO = _CO2CULTDAO;
        minter = _minter;
        descriptor = _descriptor;
        //seeder = _seeder; // @CO2CULT Seeder not necessary for CO2CULT purposes.
        proxyRegistry = _proxyRegistry;
    }

    /**
     * @notice The IPFS URI of contract-level metadata.
     */
    function contractURI() public view returns (string memory) {
        return string(abi.encodePacked('ipfs://', _contractURIHash));
    }

    /**
     * @notice Set the _contractURIHash.
     * @dev Only callable by the owner.
     */
    function setContractURIHash(string memory newContractURIHash) external onlyOwner {
        _contractURIHash = newContractURIHash;
    }

    /**
     * @notice Override isApprovedForAll to whitelist user's OpenSea proxy accounts to enable gas-less listings.
     * @CO2CULT CO2CULT will adapt this pattern - Note more DD needed.
     */
    function isApprovedForAll(address owner, address operator) public view override(IERC721, ERC721) returns (bool) {
        // Whitelist OpenSea proxy contract for easy trading.
        if (proxyRegistry.proxies(owner) == operator) {
            return true;
        }
        return super.isApprovedForAll(owner, operator);
    }

    /**
     * @notice Mint a Noun to the minter, along with a possible nounders reward
     * Noun. Nounders reward Nouns are minted every 10 Nouns, starting at 0,
     * until 183 nounder Nouns have been minted (5 years w/ 24 hour auctions).
     * @dev Call _mintTo with the to address(es).
     * @CO2CULT Names are adapted to the CO2CULT context.
     * @CO2CULT In the current CO2CULT context where artists product the NFT art,
     * @CO2CULT it might not make sense to stop receiving 10% of the mint after
     * @CO2CULT some number of mints. The limit has been removed.
     */
    function mint() public override onlyMinter returns (uint256) {
        if (_currentCO2OrbsId % 10 == 0) {
            _mintTo(CO2CULTDAO, _currentCO2OrbsId++);
        }
        return _mintTo(minter, _currentCO2OrbsId++);
    }

    /**
     * @notice Burn a noun.
     * @CO2CULT Names are adapted to the CO2CULT context.
     */
    function burn(uint256 CO2OrbsId) public override onlyMinter {
        _burn(CO2OrbsId);
        emit CO2OrbBurned(CO2OrbsId);
    }

    /**
     * @notice A distinct Uniform Resource Identifier (URI) for a given asset.
     * @dev See {IERC721Metadata-tokenURI}.
     * @CO2CULT Names are adapted to the CO2CULT context.
     * @CO2CULT (seed is removed).
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), 'CO2OrbsToken: URI query for nonexistent token');
        return descriptor.tokenURI(tokenId);
    }

    /**
     * @notice Similar to `tokenURI`, but always serves a base64 encoded data URI
     * with the JSON contents directly inlined.
     * @CO2CULT Names and functions are adapted to the CO2CULT context.
     * @CO2CULT (seed is removed).
     */
    function dataURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), 'CO2OrbsToken: URI query for nonexistent token');
        return descriptor.dataURI(tokenId);
    }

    /**
     * @notice Set the nounders DAO.
     * @dev Only callable by the nounders DAO when not locked.
     * @CO2CULT Function and variable names are adapted to the CO2CULT context.
     */
    function setCO2CULTDAO(address _CO2CULTDAO) external override onlyCO2CULTDAO {
        CO2CULTDAO = _CO2CULTDAO;

        emit CO2CULTDAOUpdated(_CO2CULTDAO);
    }

    /**
     * @notice Set the token minter.
     * @dev Only callable by the owner when not locked.
     */
    function setMinter(address _minter) external override onlyOwner whenMinterNotLocked {
        minter = _minter;

        emit MinterUpdated(_minter);
    }

    /**
     * @notice Lock the minter.
     * @dev This cannot be reversed and is only callable by the owner when not locked.
     */
    function lockMinter() external override onlyOwner whenMinterNotLocked {
        isMinterLocked = true;

        emit MinterLocked();
    }

    /**
     * @notice Set the token URI descriptor.
     * @dev Only callable by the owner when not locked.
     * @CO2CULT A token descriptor contract is very useful for generative NFTs.
     * @CO2CULT In the CO2CULT context it is used for onchain NFT storage.
     */
    function setDescriptor(ICO2OrbsDescriptor _descriptor) external override onlyOwner whenDescriptorNotLocked {
        descriptor = _descriptor;

        emit DescriptorUpdated(_descriptor);
    }

    /**
     * @notice Lock the descriptor.
     * @dev This cannot be reversed and is only callable by the owner when not locked.
     * @CO2CULT This may serve to increase transparency for the end-user regarding
     * @CO2CULT service guarantees. The descriptor serves the dataURI fallback
     * @CO2CULT functionality.
     */
    function lockDescriptor() external override onlyOwner whenDescriptorNotLocked {
        isDescriptorLocked = true;

        emit DescriptorLocked();
    }

    /**
     * @notice Set the token seeder.
     * @dev Only callable by the owner when not locked.
     * @CO2CULT The Seeder functionality is not strongly applicable to the CO2CULT
     * @CO2CULT context as randomness is not used.
     /**
    function setSeeder(INounsSeeder _seeder) external override onlyOwner whenSeederNotLocked {
        seeder = _seeder;

        emit SeederUpdated(_seeder);
    }
    */

    /**
     * @notice Lock the seeder.
     * @dev This cannot be reversed and is only callable by the owner when not locked.
     * @CO2CULT This seems to be about service guarantees again; once a proven seeder
     * @CO2CULT is present, the seeder will be locked so the address doesn't change.
     * @CO2Cult For CO2CULT purposes this section will not be necessary.
     */
    /**
    function lockSeeder() external override onlyOwner whenSeederNotLocked {
        isSeederLocked = true;

        emit SeederLocked();
    }
    */

    /**
     * @notice Mint a Noun with `nounId` to the provided `to` address.
     * @CO2CULT This functionality will only be relevant if the DAO decides to
     * @CO2CULT turn on Seeder functionality with random bit-values generated
     * @CO2CULT for a series of NFT attributes. Initially for CO2CULT, this will
     * @CO2CULT serve to generate a different file ID from the token ID. This
     * @CO2CULT will not be implemented as artists will produce the NFT art.
     */
    function _mintTo(address to, uint256 CO2OrbsId) internal returns (uint256) {

        _mint(owner(), to, CO2OrbsId);
        emit CO2OrbCreated(CO2OrbsId);

        return CO2OrbsId;
    }
}
