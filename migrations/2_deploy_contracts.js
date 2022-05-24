var MyContract = artifacts.require("./Stake.sol");

module.exports = function(deployer) {
  deployer.deploy(Stake);
};
