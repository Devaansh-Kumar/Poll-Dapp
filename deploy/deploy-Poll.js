  const { network } = require("hardhat");

module.exports = async ({getNamedAccounts, deployments}) => {
    const { deploy, log, get } = deployments;
    const { deployer } = await getNamedAccounts();
    const chainId = network.config.chainId;

    const pollContract = await deploy("Poll", {
        from: deployer,
        args: [],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    });
};

module.exports.tags = ["all", "poll"];