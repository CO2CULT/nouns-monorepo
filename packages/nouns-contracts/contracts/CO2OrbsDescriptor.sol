// SPDX-License-Identifier: GPL-3.0

/// @title The Nouns NFT descriptor

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

// @CO2Cult updated imports
import { Ownable } from '@openzeppelin/contracts/access/Ownable.sol';
import { Strings } from '@openzeppelin/contracts/utils/Strings.sol';
import { ICO2OrbsDescriptor } from './interfaces/ICO2OrbsDescriptor.sol';// @CO2CULT Note interfaces have not yet been coded for CO2CULT.
import { CO2OrbsNFTDescriptor } from './libs/CO2OrbsNFTDescriptor.sol';// @CO2CULT Note interfaces have not yet been coded for CO2CULT.

contract CO2OrbsDescriptor is ICO2OrbsDescriptor, Ownable {
    using Strings for uint256;

    // prettier-ignore
    // https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt
    bytes32 constant COPYRIGHT_CC0_1_0_UNIVERSAL_LICENSE = 0xa2010f343487d3f7618affe54f789f5487602331c0a8d03f49e9a7c547cf0499;

    // Whether or not new Noun parts can be added
    // @CO2CULT Not relevant to CO2Orbs which has a potentially infinite supply
    // @CO2CULT with demand controlled mainly by burning of unbought auction mints.
    //bool public override arePartsLocked;

    // Whether or not `tokenURI` should be returned as a data URI (Default: true)
    bool public override isDataURIEnabled = true;

    // Base URI
    string public override baseURI;

    // Noun Color Palettes (Index => Hex Colors)
    // @CO2CULT Not currently relevant as CO2Orbs will be artist-generated SVGs.
    //mapping(uint8 => string[]) public override palettes;

    /**
    * @CO2Cult Only orbs need to be stored in the case of CO2Orbs
    // Noun Backgrounds (Hex Colors)
    string[] public override backgrounds;

    // Noun Bodies (Custom RLE)
    bytes[] public override bodies;

    // Noun Accessories (Custom RLE)
    bytes[] public override accessories;

    // Noun Heads (Custom RLE)
    bytes[] public override heads;

    // Noun Glasses (Custom RLE)
    bytes[] public override glasses;
    */

    // CO2Orbs (SVG format)
    string[] public override unmintedCO2Orbs;
    string[] public override mintedCO2Orbs;


    /**
     * @notice Require that the parts have not been locked.
     */
     /**
     * @C02CULT Not relevant for CO2Orbs as they do not have generated parts.
    modifier whenPartsNotLocked() {
        require(!arePartsLocked, 'Parts are locked');
        _;
    }
     */

    /**
     * @notice Get the number of available Noun `backgrounds`.
     * @CO2CULT An orb count will be provided in a similar vein to the below.
     */
    /**
    function backgroundCount() external view override returns (uint256) {
        return backgrounds.length;
    }
    */
    /**
     * @notice Get the number of available Noun `bodies`.
     * @CO2CULT An orb count will be provided in a similar vein to the below.
     */
     /**
    function bodyCount() external view override returns (uint256) {
        return bodies.length;
    }
    */
    /**
     * @notice Get the number of available Noun `accessories`.
     * @CO2CULT An orb count will be provided in a similar vein to the below.
     */
     /**
    function accessoryCount() external view override returns (uint256) {
        return accessories.length;
    }
    */
    /**
     * @notice Get the number of available Noun `heads`.
     * @CO2CULT An orb count will be provided in a similar vein to the below.
     */
     /**
    function headCount() external view override returns (uint256) {
        return heads.length;
    }
    */
    /**
     * @notice Get the number of available Noun `glasses`.
     * @CO2CULT An orb count will be provided in a similar vein to the below.
     */
    /**
    function glassesCount() external view override returns (uint256) {
        return glasses.length;
    }
    */

    /**
    * @CO2CULT Note that the unminted CO2Orbs are uploaded by CO2CULT
    * @CO2CULT before the auctions and mint
     */
    function unmintedCO2OrbsCount() external view override returns (uint256) {
        return unmintedCO2Orbs.length;
    }

    function mintedCO2OrbsCount() external view override returns (uint256) {
        return mintedCO2Orbs.length;
    }

    // @CO2CULT Note CO2Orbs can be added via a similar function, but the below
    // @CO2CULT specific functions are irrelevant for CO2Orbs.
    /**
     * @notice Add colors to a color palette.
     * @dev This function can only be called by the owner.
     */
     /*
    function addManyColorsToPalette(uint8 paletteIndex, string[] calldata newColors) external override onlyOwner {
        require(palettes[paletteIndex].length + newColors.length <= 256, 'Palettes can only hold 256 colors');
        for (uint256 i = 0; i < newColors.length; i++) {
            _addColorToPalette(paletteIndex, newColors[i]);
        }
    }
    */
    /**
     * @notice Batch add Noun backgrounds.
     * @dev This function can only be called by the owner when not locked.
     */
     /*
    function addManyBackgrounds(string[] calldata _backgrounds) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _backgrounds.length; i++) {
            _addBackground(_backgrounds[i]);
        }
    }
    */
    /**
     * @notice Batch add Noun bodies.
     * @dev This function can only be called by the owner when not locked.
     */
     /*
    function addManyBodies(bytes[] calldata _bodies) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _bodies.length; i++) {
            _addBody(_bodies[i]);
        }
    }
    */
    /**
     * @notice Batch add Noun accessories.
     * @dev This function can only be called by the owner when not locked.
     */
     /*
    function addManyAccessories(bytes[] calldata _accessories) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _accessories.length; i++) {
            _addAccessory(_accessories[i]);
        }
    }
    */
    /**
     * @notice Batch add Noun heads.
     * @dev This function can only be called by the owner when not locked.
     */
     /*
    function addManyHeads(bytes[] calldata _heads) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _heads.length; i++) {
            _addHead(_heads[i]);
        }
    }
    */
    /**
     * @notice Batch add Noun glasses.
     * @dev This function can only be called by the owner when not locked.
     */
     /*
    function addManyGlasses(bytes[] calldata _glasses) external override onlyOwner whenPartsNotLocked {
        for (uint256 i = 0; i < _glasses.length; i++) {
            _addGlasses(_glasses[i]);
        }
    }
    */



    /**@CO2CULT The following functions allow for the CO2CULT to store svg
    * @CO2CULT CO2Orbs onchain for minting via auction. 
     */

    function addCO2Orbs(string[] calldata _co2Orbs) external override onlyOwner {
        for (uint256 i = 0; i < _co2Orbs.length; i++) {
            _addCO2Orb(_co2Orbs[i]);
        }
    }


    function addCO2Orb(string calldata _co2Orb) external override onlyOwner {
        _addCO2Orb(_co2Orb);
    }



    /**
     * @notice Add a single color to a color palette.
     * @dev This function can only be called by the owner.
     */
     /*
    function addColorToPalette(uint8 _paletteIndex, string calldata _color) external override onlyOwner {
        require(palettes[_paletteIndex].length <= 255, 'Palettes can only hold 256 colors');
        _addColorToPalette(_paletteIndex, _color);
    }
    */
    /**
     * @notice Add a Noun background.
     * @dev This function can only be called by the owner when not locked.
     */
     /*
    function addBackground(string calldata _background) external override onlyOwner whenPartsNotLocked {
        _addBackground(_background);
    }
    */

    
    /**
     * @notice Add a Noun body.
     * @dev This function can only be called by the owner when not locked.
     * @CO2CULT This function is unnecessary for CO2Orbs
     */
    /*
    function addBody(bytes calldata _body) external override onlyOwner whenPartsNotLocked {
        _addBody(_body);
    }
    */

    /**
     * @notice Add a Noun accessory.
     * @dev This function can only be called by the owner when not locked.
     * @CO2CULT This function is unnecessary for CO2Orbs
     */
     /*
    function addAccessory(bytes calldata _accessory) external override onlyOwner whenPartsNotLocked {
        _addAccessory(_accessory);
    }
    */

    /**
     * @notice Add a Noun head.
     * @dev This function can only be called by the owner when not locked.
     * @CO2CULT This function is unnecessary for CO2Orbs
     */
     /*
    function addHead(bytes calldata _head) external override onlyOwner whenPartsNotLocked {
        _addHead(_head);
    }
    */

    /**
     * @notice Add Noun glasses.
     * @dev This function can only be called by the owner when not locked.
     * @CO2CULT This function is unnecessary for CO2Orbs
     */
     /*
    function addGlasses(bytes calldata _glasses) external override onlyOwner whenPartsNotLocked {
        _addGlasses(_glasses);
    }
    */

    /**
     * @notice Lock all Noun parts.
     * @dev This cannot be reversed and can only be called by the owner when not locked.
     * @CO2CULT This function is unnecessary for CO2Orbs
     */
    /*
    function lockParts() external override onlyOwner whenPartsNotLocked {
        arePartsLocked = true;

        emit PartsLocked();
    }
    */

    /**
     * @notice Toggle a boolean value which determines if `tokenURI` returns a data URI
     * or an HTTP URL.
     * @dev This can only be called by the owner.
     * @CO2CULT This fuctionality will be maintained. However, as the CO2Orbs are natively
     * @CO2CULT SVG, it is unlikely that tokenURIs will be used.
     */
    function toggleDataURIEnabled() external override onlyOwner {
        bool enabled = !isDataURIEnabled;

        isDataURIEnabled = enabled;
        emit DataURIToggled(enabled);
    }

    /**
     * @notice Set the base URI for all token IDs. It is automatically
     * added as a prefix to the value returned in {tokenURI}, or to the
     * token ID if {tokenURI} is empty.
     * @dev This can only be called by the owner.
     */
    function setBaseURI(string calldata _baseURI) external override onlyOwner {
        baseURI = _baseURI;

        emit BaseURIUpdated(_baseURI);
    }

    /**
     * @notice Given a token ID and seed, construct a token URI for an official Nouns DAO noun.
     * @dev The returned value may be a base64 encoded data URI or an API URL.
     * @CO2CULT This function, along with art storage, are key aspects to this contract.
     */
    function tokenURI(uint256 tokenId) external view override returns (string memory) {
        if (isDataURIEnabled) {
            return dataURI(tokenId);
        }
        return string(abi.encodePacked(baseURI, tokenId.toString()));
    }

    /**
     * @notice Given a token ID and seed, construct a base64 encoded data URI for an official Nouns DAO noun.
     * @CO2CULT This function provides the dataURI for a CO2Orb NFT. Seeds have been removed.
     */
    function dataURI(uint256 tokenId) public view override returns (string memory) {
        string memory CO2OrbsId = tokenId.toString();
        string memory name = string(abi.encodePacked('CO2Orb ', nounId));
        string memory description = string(abi.encodePacked('CO2Orb ', nounId, ' is a member of the CO2CULT'));

        return genericDataURI(name, description, tokenId);
    }

    /**
     * @notice Given a name, description, and seed, construct a base64 encoded data URI.
     * @CO2CULT NFTDescriptor has been separately adapted for CO2CULT purposes.
     * @CO2CULT Seeds have been removed for CO2Orbs.
     */
    function genericDataURI(
        string memory name,
        string memory description,
        uint tokenId
    ) public view override returns (string memory) {
        CO2OrbsNFTDescriptor.TokenURIParams memory params = CO2OrbsNFTDescriptor.TokenURIParams({
            name: name,
            description: description,
            svgImage: mintedCO2Orbs[tokenId]
        });
        return CO2OrbsNFTDescriptor.constructTokenURI(params);
    }

    /**
     * @notice Given a seed, construct a base64 encoded SVG image.
     * @CO2CULT This can be removed as the CO2Orbs are in SVG format.
     *//*
    function generateSVGImage(ICO2OrbsSeeder.Seed memory seed) external view override returns (string memory) {
        MultiPartRLEToSVG.SVGParams memory params = MultiPartRLEToSVG.SVGParams({
            parts: _getPartsForSeed(seed),
            background: backgrounds[seed.background]
        });
        return NFTDescriptor.generateSVGImage(params, palettes);
    }
    */
    /**  
    * @CO2CULT The following section of code is unnecessary for
    * @CO2CULT the CO2OrbsDescriptor. However CO2Orbs do need to
    * @CO2CULT similarly added.
    */
    function _addCO2Orb(string calldata _co2Orb) internal {
        unmintedCO2Orbs.push(_co2Orb);
    }    




    /**
     * @notice Add a single color to a color palette.
    
    function _addColorToPalette(uint8 _paletteIndex, string calldata _color) internal {
        palettes[_paletteIndex].push(_color);
    }

    /**
     * @notice Add a Noun background.
    
    function _addBackground(string calldata _background) internal {
        backgrounds.push(_background);
    }

    /**
     * @notice Add a Noun body.
    
    function _addBody(bytes calldata _body) internal {
        bodies.push(_body);
    }

    /**
     * @notice Add a Noun accessory.
    
    function _addAccessory(bytes calldata _accessory) internal {
        accessories.push(_accessory);
    }

    /**
     * @notice Add a Noun head.
    
    function _addHead(bytes calldata _head) internal {
        heads.push(_head);
    }

    /**
     * @notice Add Noun glasses.
    
    function _addGlasses(bytes calldata _glasses) internal {
        glasses.push(_glasses);
    }

    /**
     * @notice Get all Noun parts for the passed `seed`.
    
    function _getPartsForSeed(ICO2OrbsSeeder.Seed memory seed) internal view returns (bytes[] memory) {
        bytes[] memory _parts = new bytes[](4);
        _parts[0] = bodies[seed.body];
        _parts[1] = accessories[seed.accessory];
        _parts[2] = heads[seed.head];
        _parts[3] = glasses[seed.glasses];
        return _parts;
    }
    */
}
