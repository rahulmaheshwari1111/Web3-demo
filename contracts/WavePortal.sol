// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract WavePortal{
    uint256 totalWaves;



    uint private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave{
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.

 
    }
  
  Wave[] waves; //to store the array of struct
 mapping(address => uint256) public lastWavedAt;

    constructor() payable{
        console.log("yoyo I am a contract ");

        seed = (block.timestamp + block.difficulty) % 100;
    }




    function wave(string memory _message)public{
     
     require(lastWavedAt[msg.sender] +  15 minutes < block.timestamp, 
    "try after 15 minutes" );



console.log(block.timestamp, "this is normal timestamp" , (block.timestamp + 15 minutes) ,"this is with added minutes");
    lastWavedAt[msg.sender] = block.timestamp;

      totalWaves +=1;
      console.log("this person has waved and messaged ", msg.sender );
      console.log("the message is", _message);


      waves.push(Wave(msg.sender, _message, block.timestamp));

  /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);



// now applying the condition for seed

if(seed<=50){
    console.log(" this user won ether" , msg.sender);

     uint256 prizeAmount = 0.0001 ether;

      require(
          prizeAmount <= address(this).balance, "Trying to withdraw more money than balance"
      );
     
     //address(this).balance is the balance of the contract itself.

      (bool success, ) = (msg.sender).call{value:prizeAmount}("");

      //(msg.sender).call{value: prizeAmount}("") is the magic line where we send money :). The syntax is a little weird! Notice how we pass it prizeAmount!

      require(success, "Failed to withdraw money from contract");
}
     

     


       emit NewWave(msg.sender, block.timestamp, _message);

    }






    function getAllWaves()public view returns(Wave[] memory){
        return waves;
    }



    
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}

