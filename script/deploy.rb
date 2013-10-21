#!/usr/bin/env ruby

require 'rubygems'

if ARGV.size < 1 or ARGV.include?('help')
  puts "Please use 'script/deploy host [port]"
else
  dest = ARGV[0]
  port = ARGV[1]
  port ||= 22
  system("cap HOSTS=#{dest}:#{port} deploy")
end