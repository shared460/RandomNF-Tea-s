//SPDX-License-Identifier: MIT

//mission
//1. give the contract some svg code
//2. output an NFT URI with the svg code
//3. storing all the NFT metadata on-chain

pragma solidity^ 0.8.19;
import 'hardhat/console.sol';

//it is exact same as ERC721.sol
import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import 'base64-sol/base64.sol';

contract SVGNFT is ERC721URIStorage{

    uint256 tokenId;
    event createSVGNFT(uint256 indexed tokenId, string tokenURI );

    //this is a collection of all the nfts of SVGNFT 
    //we send name and sumbol of our collection of nft's
    constructor() ERC721('SVGNFT', 'svgnft'){
        console.log('contract is deploying... i am in constructor...');
        tokenId = 0;
    }

    function create(string memory _svg) public{
        _safeMint(msg.sender, tokenId);
        string memory imageURI = createSVGImageURI(_svg);
        string memory tokenURI = createTokenURI(imageURI);
        _setTokenURI(tokenId, tokenURI);
        tokenId = tokenId + 1;
        /* evemts */
        emit createSVGNFT( tokenId, tokenURI );
    }

    //this function will not see and change anyhting out of this contract so pure
    function createSVGImageURI(string memory _svg) public pure returns(string memory){

        console.log('svg is forming and converting into HTML and CSS image in form of link...');
        //data:image/svg+xml;base64,<Base65-encoding>   this is the starting point

        string memory baseURL = 'data:image/svg+xml;base64,';   //it is in string
        //Bas64 converts the binary assests into HTML ans css
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg))));
        //ffdfpqqqsaXVFBHY... is look like base64 encoded

        //connecting the string
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
        console.log('data:image/svg+xml;base64,<Base65-encoding> this form is ready...');

        return(imageURI);

    }


    function createTokenURI(string memory _imageURI) public pure returns(string memory){
        //tokn uri is in json format
        //all connected in form of string

        console.log('creating an toeknURI...');

        string memory baseURL = 'data:application/json;base64,';   //it is in string

        //this is how we make the metadata of NFT
        string memory json = Base64.encode(bytes(abi.encodePacked(
            '{"name": "SVGNFT"',
            ',"description": "An NFT based on SVG!"',
            ',"attributes": ""',
            ',"image":"',_imageURI, '"}')));

        string memory tokenURI = string(abi.encodePacked(baseURL, json));
        console.log('tokenURI -> ',tokenURI);

        return(tokenURI);
    }

}


