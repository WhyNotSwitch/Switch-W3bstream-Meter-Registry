const Registry = artifacts.require("Registry")

module.exports = async function (deployer) {
    await deployer.deploy(Registry);
    const instance = await Registry.deployed();
    console.log("deployed at", instance.address);
}