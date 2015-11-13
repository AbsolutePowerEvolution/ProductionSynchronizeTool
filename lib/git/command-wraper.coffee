Path = require 'path'
ChildProcess = require 'child_process'
Config = require '../config'

When = require 'when'

GitCommand = "git --work-tree=#{Config.path}
                --git-dir=#{Path.join(Config.path, '.git')}"

module.exports = Git =
  GitCommand: GitCommand

  fetch: (ref, child_process = ChildProcess) ->
    new When.Promise (resolve, reject) ->
      child_process.exec("#{GitCommand} fetch #{ref}").on 'exit', (err) ->
        if err
          reject(err)
        else
          resolve()

  stash: (child_process = ChildProcess) ->
    new When.Promise (resolve, reject) ->
      child_process.exec("#{GitCommand} stash").on 'exit', (err) ->
        if err
          reject(err)
        else
          resolve()

  stashPop: (child_process = ChildProcess) ->
    new When.Promise (resolve, reject) ->
      child_process.exec("#{GitCommand} stash pop").on 'exit', (err) ->
        if err
          reject(err)
        else
          resolve()

