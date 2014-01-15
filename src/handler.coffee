async = require('async')
client = require('./client.js')
config = require('./config')
os = require('os')

class Handler

  exception: (err, clu, callback = ->) =>
    _err = err.err
    _process = err.process

    pm_uptime = _process.pm2_env?.pm_uptime or 0
    return callback(new Error('CRASHTOOFAST')) unless new Date - pm_uptime > config.minUptime

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
          proc: JSON.stringify(_process, null, 2)
          loadavg: os.loadavg().join(', ')
          memoryUsage: JSON.stringify(process.memoryUsage())
        template: 'crashmail'
      client.call('email.send', email, next)
    , callback

handler = new Handler
handler.Handler = Handler
module.exports = handler
