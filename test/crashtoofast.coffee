should = require('should')
ipm2 = require('pm2-interface')(require('./constants'))
handler = require('../lib/handler')
path = require('path')

describe 'monitor#handler', ->

  describe 'handler.crashtoofast', ->
    it 'should callback CRASHTOOFAST error', (done) ->
      ipm2.bus.on 'process:exception', (err, clu) ->
        handler.exception err, clu, (err) ->
          err.message.should.be.eql('CRASHTOOFAST')
          done()
