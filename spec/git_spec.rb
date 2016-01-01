#!/usr/bin/env ruby
# encoding: UTF-8

require 'spec_helper'

require 'git'

# For mocking
require 'rugged'

describe Git do
  let(:mock_repo) { mock }

  before(:each) do
    Rugged::Repository.stubs(:new).with('.').returns(mock_repo)
  end

  describe '#repo_modify' do
    context 'when nothing modify' do
      it 'should return empty array' do
        mock_repo.expects(:status).yields('foo', [:worktree_new])
        git = Git.new
        expect(git.repo_modify).to eq []
      end
    end

    context 'when worktree have modify' do
      it 'should return it filename' do
        mock_repo.expects(:status).yields('foo', [:worktree_modified])
          .yields('bar', [:worktree_new])
        git = Git.new
        expect(git.repo_modify).to eq ['foo']
      end
    end
  end
end
