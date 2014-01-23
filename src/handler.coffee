async = require('async')
client = require('./client.js')
config = require('./config')
os = require('os')
logger = require('graceful-logger')

class Handler

  exception: (err, clu, callback = ->) =>
    _err = err.err
    _process = err.process

    pm_uptime = _process.pm2_env?.pm_uptime or 0
    return callback(new Error('CRASHTOOFAST')) unless new Date - pm_uptime > config.minUptime

    params =
      date: new Date
      stack: _err.stack
      message: _err.message
      pid: _process.process.pid
      name: _process.pm2_env?.name
      pmId: _process.pm2_env?.pm_id
      proc: JSON.stringify(_process, null, 2)
      loadavg: os.loadavg().join(', ')
      freemem: Math.round(os.freemem()/1024/1024) + ' MB'
      uptime: Math.floor((new Date - pm_uptime) / 1000) + ' S'

    logger.warn("exception[#{_process.pm2_env?.name}]: #{_err.message} ")
    logger.warn(params)

    async.each config.emails, (to, next) ->
      email =
        to: to
        subject: 'Crash Mail'
        params: params
        template: 'crashmail'
      client.call('email.send', email, next)
    , callback

handler = new Handler
handler.Handler = Handler
module.exports = handler
