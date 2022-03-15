// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract WavePortal{
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave{
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }
  
  Wave[] waves; //to store the array of structs



    constructor() payable{
        console.log("yoyo I am a contract ");
    }




    function wave(string memory _message)public{
      totalWaves +=1;
      console.log("this person has waved and messaged ", msg.sender );
      console.log("the message is", _message);


      waves.push(Wave(msg.sender, _message, block.timestamp));


      emit NewWave(msg.sender, block.timestamp, _message);

      uint256 prizeAmount = 0.001 ether;

      require(
          prizeAmount <= address(this).balance, "Trying to withdraw more money than balance"
      );
     
     //address(this).balance is the balance of the contract itself.

      (bool success, ) = (msg.sender).call{value:prizeAmount}("");

      //(msg.sender).call{value: prizeAmount}("") is the magic line where we send money :). The syntax is a little weird! Notice how we pass it prizeAmount!

      require(success, "Failed to withdraw money from contract");

    }






    function getAllWaves()public view returns(Wave[] memory){
        return waves;
    }



    
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}

