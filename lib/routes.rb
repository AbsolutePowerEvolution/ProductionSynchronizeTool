#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'

require 'sinatra'
require 'sinatra/contrib'

def pull
  # TODO: Implent git pull
end

post '/' do
  request.body.rewind
  event = request.env['HTTP_X_GITHUB_EVENT']
  payload = JSON.parse(request.body.read, symbolize_names: true)
  if event == 'push'
    if payload[:ref].end_with? 'master'
      pull
    end
  end
end
