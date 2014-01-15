ipm2 = require('pm2-interface')(require('./constants'))
handler = require('../lib/handler')
path = require('path')

describe 'monitor#handler', ->

  describe 'handler.exception', ->
    it 'should callback by send mail', (done) ->
      ipm2.bus.on 'process:exception', (err, clu) ->
        handler.exception(err, clu, done)
