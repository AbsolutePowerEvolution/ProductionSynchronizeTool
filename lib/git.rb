#!/usr/bin/env ruby
# encoding: UTF-8

require 'rugged'

require_relative 'config'
require_relative 'exception'

class Git
  GitError = ProductionSync::GitError # Alias for exception

  def pull
    remote_check
    remote = repo.remotes[remote_name]
    remote.fetch
    repo.merge_base 'master', "remotes/#{remote_name}/master"
  end

  def remote_check
    remote = repo.remotes[remote_name]
    fail GitError, "Remote #{remote_name} not exist" if remote.nil?
    fail GitError, 'Please use http or https url for remote' if ssh? remote.url
    fail GitError, 'Repo has been modify' if repo_clean?
    true
  end

  def repo_clean?
    repo_modify.empty?
  end

  def repo_modify
    modify = []
    repo.status do |file, info|
      modify << file if modify? info
    end
    modify
  end

  private

  def repo
    @repo ||= Rugged::Repository.new(Config.repo_path)
  rescue Rugged::RepositoryError
    raise ProductionSync::GitError, "#{Config.repo_path} is not a git repo"
  end

  def remote_name
    @remote_name ||= Config.remote_name || 'origin'
  end

  def modify?(info)
    info.include?(:worktree_modified) || info.include?(:index_modified)
  end

  def ssh?(url)
    url.start_with? 'ssh'
  end
end
