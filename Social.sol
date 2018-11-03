pragma solidity ^0.4.19;

contract Social {
    
    struct User {
        string name;
        string description;
        address owner;
        uint creationDate;
    }
    
    mapping(bytes32 => User) public user;
    
    mapping(address => bytes32) public owner;
    
    event createUser(
        string name,
        string description,
        address owner,
        uint creationDate
    );
    
    event getUser(
        string name,
        string description,
        address owner,
        uint creationDate
    );
    
    function createAccount(string _name, string _description) public {
        
        require(bytes(_name).length > 0);
        
        bytes32 hashAddress = keccak256(abi.encodePacked(_name, _description));
        
        user[hashAddress].name = _name;
        user[hashAddress].description = _description;
        user[hashAddress].owner = msg.sender;
        user[hashAddress].creationDate = now;
        
        owner[user[hashAddress].owner] = hashAddress;
    
        emit createUser(_name, _description, user[hashAddress].owner, user[hashAddress].creationDate );
    }
    
    
    function getAccountDetails(address userAddress) public {
        
        //require(userAddress != msg.sender);
        
        bytes32 getOwnerAddress = owner[userAddress];
        
        emit getUser(user[getOwnerAddress].name, user[getOwnerAddress].description, user[getOwnerAddress].owner, user[getOwnerAddress].creationDate);
    }
}
