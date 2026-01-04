// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/*
A simple contract that allows users to deposit Ether
while the owner can view balances, access sender details and withdraw funds
*/
contract PersonalSavingsBank
{
    struct SenderDetails  // Struct to store sender details
    {
        string Name;
        uint Amount;
    }
    address public owner;
    mapping (address => SenderDetails) private SenderMapping;  // Mapping to store sender details (kept private for access control)
    
    constructor ()
    {
        owner = msg.sender;  //making the deployer-owner of the contract
    }
    
    //Function that allows any user to send ETH (Ether) to the contract while also storing sender details
    function deposit(string memory _name) public payable
    {
        require(msg.value > 0, "Cannot deposit zero Ether");  //Reject zero-value deposits
        require(bytes(_name).length > 0, "Please enter a name");  //Reject empty name
        
        SenderDetails storage person = SenderMapping[msg.sender];
        if(bytes(person.Name).length == 0)  //Name of the sender can be set only once
        {
            person.Name = _name;
        }
        person.Amount += msg.value;  //Amount sent by the sender can accumulates over multiple deposits

    }

    //Function that allows only the contract owner to withdraw ETH
    function withdraw(uint _amount) public
    {
        require(msg.sender == owner, "Only Owner can withdraw funds");
        require(_amount <= address(this).balance, "Insufficient Balance");  //Withdraw amount cannot be more than the contract balance
        payable(msg.sender).transfer(_amount);
    }

    //Function that allows only the contract owner to view the contract balance
    function getBalance() public view returns(uint)
    {
        require(msg.sender == owner, "Only Owner can check balance");
        return address(this).balance;
    }

    //Function that allows only the contract owner to view sender details
    function getSender(address _user) public view returns(string memory, uint)
    {
        require(msg.sender == owner, "Only Owner can access sender details");
        SenderDetails storage person = SenderMapping[_user];
        return (person.Name, person.Amount);
    }
}