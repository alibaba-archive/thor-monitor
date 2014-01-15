async = require('async')
client = require('./client.js')
config = require('./config')

class Handler

  exception: (err, clu, callback = ->) =>
    _err = err.err
    _process = err.process

    # TODO ignore infinite loop restart

    async.each config.emails, (to, next) ->
      email =
        to: to
        subject: 'Crash Mail'
        params:
          date: new Date
          stack: _err.stack
          message: _err.message
          pid: _process.process.pid
          name: _process.pm2_env?.name
          pmId: _process.pm2_env?.pm_id
          prc: JSON.stringify(_process, null, 2)
        template: 'crashmail'
      client.call('email.send', email, next)
    , callback

handler = new Handler
handler.Handler = Handler
module.exports = handler
