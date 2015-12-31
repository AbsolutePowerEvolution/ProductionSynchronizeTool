#!/usr/bin/env ruby
# encoding: UTF-8

module ProductionSync
  class ProductionSyncError < ::RuntimeError
  end

  class GitError < ProductionSyncError
  end
end
