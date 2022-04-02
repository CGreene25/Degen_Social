//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MYToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Gold", "GLD") {
        _mint(msg.sender, initialSupply);
    }
}

contract DegenSocial {
    string public name;
    uint public postCount = 0;
    mapping(uint => Post) public posts;


    struct Post {
        uint256 postCount;
        string name;
        address owner;
        //string content;
    }

    event PostCreated(
        uint256 postCount,
        string name,
        address owner//,
    //string content
    );
    constructor() public {
        name = "Social APP";
    }

    function createPost(string memory _name, string memory _content) public {
        // Require a valid name
        require(bytes(_name).length > 0);
        //Require valid content
        require(bytes(_content).length > 0);
        // Increment product count
        postCount ++;
        // Create the product
        posts[postCount] = Post(postCount, _name, msg.sender);
        // Trigger an event
        emit PostCreated(postCount, _name, msg.sender);
    }
}
