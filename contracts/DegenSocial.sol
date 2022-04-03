//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract DegenSocial is ERC20 {
    uint public postCount = 0;
    uint public likeCount = 0;
    mapping(uint => Post) public posts;

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

    constructor() ERC20("DegenCoin", "DGN") {
        _mint(msg.sender, 10000000);
    }

    function mintMinerReward() public {
        _mint(block.coinbase, 10);
    }

    function getPostContent() public view returns (string[] memory){
        string[] memory ret = new string[](postCount);
        for (uint i = 0; i < postCount; i++) {
            ret[i] = posts[i].content;
        }
        return ret;
    }

    function getPosterName() public view returns (string[] memory){
        string[] memory ret = new string[](postCount);
        for (uint i = 0; i < postCount; i++) {
            ret[i] = posts[i].name;
        }
        return ret;
    }

    function getPosterAddress() public view returns (address[] memory){
        address[] memory ret = new address[](postCount);
        for (uint i = 0; i < postCount; i++) {
            ret[i] = posts[i].owner;
        }
        return ret;
    }

    function getLikeCount() public view returns (uint[] memory){
        uint[] memory ret = new uint[](postCount);
        for (uint i = 0; i < postCount; i++) {
            ret[i] = posts[i].likeCount;
        }
        return ret;
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
            //mint miner reward
            mintMinerReward();
        }
        // Trigger an event
        emit PostLiked(_owner, likeCount);
    }


}
