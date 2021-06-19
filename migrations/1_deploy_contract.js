const TonToken = artifacts.require("TonToken");

module.exports = function (deployer) {
  deployer.deploy(TonToken);
};
