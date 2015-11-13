lodash = require 'lodash'
Config = require 'config'

configKeys = [
  'url',
  'path',
  'address',
  'port'
]

configs = lodash.zipObject(configKeys, lodash.map(configKeys, (key) ->
  throw new Error("Config #{key} not found") unless Config.has(key)
  Config.get key
))

module.exports = Object.freeze(configs)
