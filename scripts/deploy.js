const fs = require('fs');
const { network } = require('hardhat');

const main = async()=>{
    try{

        console.log('deploying the contract ....');
        const [deployer] = await hre.ethers.getSigners();
        
        const getContract = await hre.ethers.getContractFactory('SVGNFT');
        const contract = await getContract.deploy();   //we don't want to sed anyhting to the constructor
        await contract.target;

        console.log('contract has been deployed')

        //chainIf
        const networkName = network.name;
        console.log('network name...',networkName);
        const chainId = network.config.chainId;
        console.log('chainId...',chainId);


        console.log('deployer of contract -> ',deployer.address);
        console.log('contract address -> ',contract.target);

        //reading an svg
        const svg = fs.readFileSync('/Users/sharadpoddar/Desktop/veson/NFT/week_1/img/img2.svg', 'utf-8');

        //calling the function
        const txn = await contract.create(svg);
        //it will give us an receipt as it was fromed after the confirmation of two blocks
        const res = await txn.wait(2);

        console.log('transaction_1 done successfully: ',res);

        process.exit(0);
    }catch(error){
        console.log(error);
        process.exit(1);
    }
}

main();