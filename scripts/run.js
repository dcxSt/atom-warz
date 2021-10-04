const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const atomWarContractFactory = await hre.ethers.getContractFactory('AtomWar');
    const atomWarContract = await atomWarContractFactory.deploy();
    await atomWarContract.deployed();
    console.log("Contract deployed to", atomWarContract.address);
    console.log("Contract deployed by", owner.address);

    // join gangs
    await atomWarContract.joinGang(0);
    await atomWarContract.connect(randomPerson).joinGang(1);

    // shoot a few times
    await atomWarContract.shoot();
    await atomWarContract.shoot();
    await atomWarContract.shoot();
    await atomWarContract.connect(randomPerson).shoot();
    await atomWarContract.connect(randomPerson).shoot();

    // get the scores
    let electronScore;
    let neutronScore;
    let protonScore;
    [electronScore, neutronScore, protonScore] = await atomWarContract.getScores();
    console.log("\nElecton score: %d", electronScore)
    console.log("Neutron score: %d", neutronScore);
    console.log("Proton score: %d", protonScore);

    // get the players
    let electronMembers;
    let neutronMembers;
    let protonMembers;
    electronMembers = await atomWarContract.viewMembers(0);
    neutronMembers = await atomWarContract.viewMembers(1);
    protonMembers = await atomWarContract.viewMembers(2);
    console.log("\nElectron members:")
    for (i=0; i<electronMembers.length; i++) {
        console.log(electronMembers[i]);
    }
    console.log("\nNeutron members:")
    for (i=0; i<neutronMembers.length; i++) {
        console.log(neutronMembers[i]);
    }
    console.log("\nProton members:");
    for (i=0; i<protonMembers.length; i++) {
        console.log(protonMembers[i]);
    }
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();