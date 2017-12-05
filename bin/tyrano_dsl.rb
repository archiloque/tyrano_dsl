#!/usr/bin/env ruby

require 'bundler/setup'
require 'tyrano_dsl/main'
require 'tyrano_dsl/tyrano_exception'
if ARGV.length != 1
  raise 'You need one argument : the path to the tyrano project'
end
tyrano_project_path = ARGV[0]
begin
  writing_actions = TyranoDsl::Main.new.run(TyranoDsl::Main::DEFAULT_FILENAME)
  writing_actions.each do |writing_action|
    writing_action.run(tyrano_project_path)
  end
rescue TyranoDsl::TyranoException => e
  abort(e.message)
end
