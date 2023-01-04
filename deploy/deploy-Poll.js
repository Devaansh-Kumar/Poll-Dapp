const { network } = require("hardhat");
const developmentChains = ["hardhat", "localhost"];
const { verify } = require("../utils/verify");

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

    if (
      !developmentChains.includes(network.name) &&
      process.env.ETHERSCAN_API_KEY
    ) {
      await verify(pollContract.address, []);
    }
};

module.exports.tags = ["all", "poll"];