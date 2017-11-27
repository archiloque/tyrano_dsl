#!/usr/bin/env ruby

require 'bundler/setup'
require 'tyrano_dsl/main'
if ARGV.length != 1
  raise 'You need one argument : the path to the tyrano project'
end
project_path = ARGV[0]
writing_actions = TyranoDsl::Main.new.run(TyranoDsl::Main::DEFAULT_FILENAME)
writing_actions.each do |writing_action|
  writing_action.run
end
