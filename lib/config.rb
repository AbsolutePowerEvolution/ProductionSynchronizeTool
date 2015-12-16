#!/usr/bin/env ruby
# encoding: UTF-8

require 'figaro'

APP_ROOT = File.expand_path File.join __dir__, '..'

CONFIG_PATH = File.join APP_ROOT, 'config', 'config.yml'

Figaro.application = Figaro::Application.new(path: CONFIG_PATH)
Figaro.load

Config = Figaro.env
