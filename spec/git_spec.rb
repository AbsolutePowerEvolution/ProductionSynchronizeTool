#!/usr/bin/env ruby
# encoding: UTF-8

require 'spec_helper'

require 'git'

# For mocking
require 'rugged'

describe Git do
  let(:mock_repo) { mock }
  let(:git) { Git.new }

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
        expect(git.repo_modify).to eq ['foo']
      end
    end

    context 'when staged area have modify' do
      it 'should return it filename' do
        mock_repo.expects(:status).yields('foo', [:index_modified])
          .yields('bar', [:worktree_new])
        expect(git.repo_modify).to eq ['foo']
      end
    end
  end

  describe '#repo_clean?' do
    context 'when nothing modify' do
      it 'should return true' do
        mock_repo.expects(:status)
        expect(git.repo_clean?).to be true

        mock_repo.expects(:status).yields('foo', [:worktree_new])
        expect(git.repo_clean?).to be true
      end
    end

    context 'when something modify' do
      it 'should return false' do
        mock_repo.expects(:status).yields('foo', [:worktree_modified])
        expect(git.repo_clean?).to be false

        mock_repo.expects(:status).yields('foo', [:index_modified])
        expect(git.repo_clean?).to be false
      end
    end
  end

  describe '#repo_check' do
    let(:mock_remotes) { mock }

    before(:each) do
      mock_repo.expects(:remotes).returns(mock_remotes)
    end

    context 'remote not exist' do
      it 'should fail' do
        mock_remotes.expects(:[]).with('origin').returns(nil)
        expect { git.repo_check }.to raise_error(Git::GitError)
      end
    end

    context 'remote url protocol is ssh' do
      it 'should fail' do
        mock_remotes.expects(:[]).with('origin').returns(mock(url: 'ssh://example.com/foo.git'))
        expect { git.repo_check }.to raise_error(Git::GitError)
      end
    end

    context 'repo is modify' do
      it 'should fail' do
        mock_remotes.expects(:[]).with('origin').returns(mock(url: 'https://example.com/foo.git'))
        mock_repo.expects(:status).yields('foo', [:worktree_modified])
        expect { git.repo_check }.to raise_error(Git::GitError)
      end
    end

    context 'repo is clean and remote config correct' do
      it 'should pass and return true' do
        mock_remotes.expects(:[]).with('origin').returns(mock(url: 'https://example.com/foo.git'))
        mock_repo.expects(:status)
        expect(git.repo_check).to be true
      end
    end
  end
end
