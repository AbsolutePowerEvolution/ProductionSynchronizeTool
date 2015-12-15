NodeGit = require 'nodegit'
Path = require 'path'

module.exports = (path, Git = NodeGit) ->
  path = Path.resolve path
  Git.Repository.open(path)
    .then (repo) ->
      Git.Stash.save repo
    .then (repo) ->
      Git.Fetch
