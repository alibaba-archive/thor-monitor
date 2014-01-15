#!/bin/bash

export PM2_RPC_PORT=4242
export PM2_PUB_PORT=4243

pm2=./node_modules/.bin/pm2

$pm2 start test/scripts/exception.js
./node_modules/.bin/mocha --reporter spec --compilers coffee:coffee-script test/exception.coffee
$pm2 kill
