async function main() {

    console.log("Beginning deploy.js")
  
    // ContractFactory = abstraction for deploying new s.c.
    const DegenSocial_SC = await ethers.getContractFactory("DegenSocial")
  
    console.log("1")
  
    // Start deployment, returning a promise that resolves to a contract object
    // This is the object that has a method for each of our s.c. functions
    const DegenSocial_Obj = await DegenSocial_SC.deploy()
  
    console.log("2")
  
    await DegenSocial_Obj.deployed()
  
    console.log("Contract deployed to address:", DegenSocial_Obj.address)
  
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
  