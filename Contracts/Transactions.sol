// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Transactions{
    uint256 transactionCounter;

    event Transfer( address from, address receiver, uint amount, string message, uint256 timestamp, string keyword);

    struct transferStruct {
        address sender;
        address receiver;
        uint amount;
        string message;
        uint256 timestamp;
        string keyword;
    }

    transferStruct[] transactions;

    function addTo( address receiver, uint amount, string memory message, string memory keyword ) public {
        address sender = msg.sender;

        transferStruct memory newTransfer = transferStruct(msg.sender, receiver, amount, message, block.timestamp,keyword);

        transactions.push(newTransfer);

        emit Transfer(sender, receiver, amount, message, block.timestamp, keyword);

        transactionCounter++;
    }

    function getALL() public view returns (transferStruct[] memory) {
        // return trasaction    
        return transactions;     
    }

    function getTran() public view returns ( uint256 ) {
        // return transactionCount;

        return transactionCounter;
    }


}