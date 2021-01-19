// SPDX-License-Identifier: MIT
pragma solidity >0.6.99 <0.8.1;

contract Inbox{
    string public name;
    string public message;
    uint public age;
    bool public sex;
    bytes32 public areaText;
    
    
    constructor ( string memory myName,string memory initialMessage, uint myAge, bool mySex, bytes32 myAreaText){
        name = myName;
        message = initialMessage;
        age = myAge;
        sex = mySex;
        areaText = myAreaText;
    }

    function setName(string memory newName) public {
        name = newName;
    }
    
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    function setEdad(uint newAge) public {
        age = newAge;
    }

    function setSexo(bool newSex) public {
        sex = newSex;
    }

    function setAreaText(bytes32 newAreaText) public {
        areaText = newAreaText;
    }
    
    /*
     struct book{
         string titel;
         string autor;
         uint id_book;
     }
     array
     string[]book = new string[5];
     book[0]='ddd';
    */

    /* Solidity Avanzdo 
    MSG*/
    //

}