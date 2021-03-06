#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'

require 'sinatra'
require 'sinatra/contrib'
require 'secure_headers'

require_relative 'config'
require_relative 'git'

configure do
  set :server, :puma
  set :public_folder, File.join(APP_ROOT, 'public')
end

configure :production do
  enable :reloader
end

SecureHeaders::Configuration.configure do |config|
  config.hsts = 'max-age=15552000' if Config.ssl
  config.x_frame_options = 'DENY'
  config.x_content_type_options = 'nosniff'
  config.x_xss_protection = '1; mode=block'
  config.csp = SecureHeaders::OPT_OUT
end

use SecureHeaders::Middleware

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end

post '/' do
  request.body.rewind
  event = request.env['HTTP_X_GITHUB_EVENT']
  begin
    payload = JSON.parse(request.body.read, symbolize_names: true)
    if event == 'push'
      if payload.fetch(:ref).end_with? 'master'
        git = Git.new
        git.pull
      end
      status 200
      body ''
    else
      status 422
    end
  rescue JSON::ParserError, KeyError
    status 422
  end
end
