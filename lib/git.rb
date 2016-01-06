#!/usr/bin/env ruby
# encoding: UTF-8

require 'rugged'

require_relative 'config'
require_relative 'exception'

class Git
  GitError = ProductionSync::GitError # Alias for exception

  def pull
    repo_check
    remote = repo.remotes[remote_name]
    remote.fetch
    repo_path = Config.repo_path
    git_dir = File.join repo_path, '.git'
    Dir.chdir(repo_path) do
      call_git_pull(repo_path, git_dir)
    end
  end

  def repo_check
    remote = repo.remotes[remote_name]
    fail GitError, "Remote #{remote_name} not exist" if remote.nil?
    fail GitError, 'Please use http or https url for remote' if ssh? remote.url
    fail GitError, 'Repo has been modify' unless repo_clean?
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

  def call_git_pull(repo_path, git_dir)
    `git --work-tree '#{repo_path}' --git-dir '#{git_dir}' checkout master`
    `git --work-tree '#{repo_path}' --git-dir '#{git_dir}' merge origin/master`
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
