#!/usr/bin/env ruby
# encoding: UTF-8

require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require 'routes'

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
