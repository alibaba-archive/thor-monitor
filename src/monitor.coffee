logger = require('graceful-logger').format('medium')

monitor = ->
  ipm2 = require('pm2-interface')()
  handler = require('./handler.js')

  logger.info 'thor monitor is online'

  ipm2.on 'ready', -> logger.info 'connect to pm2'
  ipm2.bus.on('process:exception', handler.exception)

module.exports = monitor
