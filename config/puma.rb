#!/usr/bin/env puma

require_relative '../lib/config.rb'

if Config.ssl
  bind "ssl://#{Config.address}:#{Config.port}"\
    "?key=#{Config.key_path}&cert=#{Config.cert_path}"
else
  bind "tcp://#{Config.address}:#{Config.port}"
end
