axon = require('axon')
req = axon.socket('req')
rpc = require('axon-rpc')
config = require('./config')

client = new rpc.Client(req)
req.connect(config.server)

module.exports = client
