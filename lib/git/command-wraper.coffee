Path = require 'path'
ChildProcess = require 'child_process'

lodash = require 'lodash'
When = require 'when'

Config = require '../config'


GitCommand = "git --work-tree=#{Config.path}
                --git-dir=#{Path.join(Config.path, '.git')}"

defineCommand = (commands) ->
  toCommand = (command) ->
    command.replace(/([A-Z])/, ' $1').toLowerCase()

  result = {}

  wrapper = (command, child_process = ChildProcess) ->
    new When.Promise (resolve, reject) ->
      child_process.exec("#{GitCommand} #{command}").on 'exit', (err) ->
        if err
          reject(err)
        else
          resolve()

  for command in commands
    result[command] = wrapper
      .bind(wrapper, toCommand(command))

  result

Git =
  GitCommand: GitCommand

  fetch: (ref, child_process = ChildProcess) ->
    new When.Promise (resolve, reject) ->
      child_process.exec("#{GitCommand} fetch #{ref}").on 'exit', (err) ->
        if err
          reject(err)
        else
          resolve()

lodash.extend Git, defineCommand(['stash', 'stashPop'])

module.exports = Git
