should = require('should')
{exec} = require('child_process')
ipm2 = require('pm2-interface')(require('./constants'))
handler = require('../lib/handler')
logger = require('graceful-logger')
path = require('path')

describe 'monitor#handler', ->

  @timeout(3000)

  describe 'handler.exception', ->
    it 'should callback exceptions', (done) ->
      ipm2.bus.on 'process:exception', (err, clu) ->
        handler.exception(err, clu, done)
