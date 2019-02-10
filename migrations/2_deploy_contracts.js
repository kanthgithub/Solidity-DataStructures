/* eslint-disable space-before-function-paren */
var Queue = artifacts.require('Queue')

module.exports = function (deployer) {
  deployer.deploy(Queue)
}