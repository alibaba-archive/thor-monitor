util = require('util')

application =
  server: 'tcp://convert.teambition:4033'
  emails: ['jingxin@teambition.com', 'qiang@teambition.com', 'sailxjx@gmail.com']
  minUptime: 5000

env =
  production: {}
  development:
    server: 'tcp://localhost:4033'
  mocha:
    minUptime: 1000
    server: 'tcp://localhost:4033'

NODE_ENV = process.env.NODE_ENV or 'development'
envConfig = env[NODE_ENV] or env['development']

config = util._extend(application, envConfig)
module.exports = config
