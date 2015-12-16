#!/usr/bin/env ruby
# encoding: UTF-8

require 'bundler/setup'
require_relative 'lib/routes.rb'

run Sinatra::Application
