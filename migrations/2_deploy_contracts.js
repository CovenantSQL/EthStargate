var Ownable = artifacts.require("openzeppelin-solidity/contracts/ownership/Ownable.sol")
var SafeMath = artifacts.require("openzeppelin-solidity/contracts/ownership/SafeMath.sol")
var Stargate = artifacts.require("./Stargate.sol")

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.deploy(SafeMath);
  deployer.link(Ownable, Stargate);
  deployer.link(SafeMath, Stargate);
  deployer.deploy(Stargate);
};
