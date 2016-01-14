#!/usr/bin/env puma

require_relative '../lib/config.rb'

PID_PATH = File.join ::APP_ROOT, 'tmp', 'run', 'puma.pid'
STATE_PATH = File.join ::APP_ROOT, 'tmp', 'run', 'puma.state'
LOG_PATH = File.join ::APP_ROOT, 'tmp', 'log'
ACCESS_LOG = File.join LOG_PATH, 'access.log'
ERROR_LOG = File.join LOG_PATH, 'error.log'

tag 'ProductionSync'

pidfile PID_PATH
state_path STATE_PATH

daemonize true

stdout_redirect ACCESS_LOG, ERROR_LOG, true

if Config.ssl == 'true'
  bind "ssl://#{Config.address}:#{Config.port}"\
    "?key=#{Config.key_path}&cert=#{Config.cert_path}"
else
  bind "tcp://#{Config.address}:#{Config.port}"
end
