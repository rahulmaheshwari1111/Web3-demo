
const main = async()=>{
//This will actually compile our contract and generate the necessary files we need to work with our contract under the artifacts directory.

const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
const waveContract = await waveContractFactory.deploy({
  value: hre.ethers.utils.parseEther("0.1"),  //funding the contract
});
await waveContract.deployed();
console.log("Contract deployed to:", waveContract.address);





// console.log("this is owner object", owner);
// console.log("this is randomPerson object", randomPerson);
// console.log("this isoth randomPerson object", oth);

/*What's happening here is Hardhat will create a local Ethereum network for us,
 but just for this contract. Then, after the script completes it'll destroy that local network. So, every time you run the contract, it'll be a fresh blockchain. What's the point? It's kinda like refreshing your local server 
every time so you always start from a clean slate which makes it easy to debug errors*/
//We'll wait until our contract is officially deployed to our local blockchain! Our constructor runs when we actually deploy.




// Getting tht balance

let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);

console.log(contractBalance, "formatted balance => " , hre.ethers.utils.formatEther(contractBalance))



/* counting 
   and
   sending the wave */



let waveCount;
waveCount = await waveContract.getTotalWaves();

let waveTxn;
waveTxn = await waveContract.wave("A message");
await waveTxn.wait(); //waitng for txn to mined


  /*
   * Get Contract balance to see what happened!
   */

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log("updated contract balance: ",
  hre.ethers.utils.formatEther(contractBalance));



const [_, randomPerson] = await hre.ethers.getSigners();
waveTxn = await waveContract.connect(randomPerson).wave("another message");
await waveTxn.wait();


let allWaves =await waveContract.getAllWaves();
console.log(allWaves, "allwaves");
}






const runMain = async () => {
    try {
      await main();
      process.exit(0); // exit Node process without error
    } catch (error) {
      console.log(error);
      process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
  };

  runMain();