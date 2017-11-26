#!/usr/bin/env ruby

require 'bundler/setup'
require 'tyrano_dsl/main'
if ARGV.length != 1
  raise 'You need one argument : the path to the tyrano project'
end
TyranoDsl::Main.new.run(ARGV[0])
