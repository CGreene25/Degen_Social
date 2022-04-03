//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract MYToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MYT") {
        _mint(msg.sender, initialSupply);
    }
}

contract ERC20FixedSupply is ERC20 {
    constructor() ERC20("Fixed", "FIX") {
        _mint(msg.sender, 10000);
    }
}

contract ERC20WithMinerReward is ERC20 {
    constructor() ERC20("Reward", "RWD") {}

    function mintMinerReward() public {
        _mint(block.coinbase, 1000);
    }
}

contract DegenSocial {
    string public name;
    uint public postCount = 0;
    uint public likeCount = 0;
    mapping(uint => Post) public posts;
    //address[] likes;
    //address _owner;



    struct Post {
        string name;
        address owner;
        string content;
        uint256 postCount;
        uint256 likeCount;
        address[] likes;
    }

    event PostCreated(string name, string content);
    event PostLiked(address owner, uint256 likeCount);

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
        uint256 likeCount = 0;
        posts[postCount] = (Post(_name, msg.sender, _content, postCount, likeCount, new address[] (0)));
        // Trigger an event
        emit PostCreated(_name, _content);
    }
    function likePost(uint256 postCount, address _owner) public {
        bool newLike = true;
        // Require unused ID
        for(uint i=0; i<posts[postCount].likes.length;i++){
            if(_owner != posts[postCount].likes[i]){
                newLike = false;
            }
        }
        if(newLike == true){
            //Increase like count
            posts[postCount].likeCount ++;
            //add address to array of likers
            posts[postCount].likes.push(_owner);
        }
        // Trigger an event
        emit PostLiked(_owner, likeCount);
    }

}
