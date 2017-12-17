#!/usr/bin/env ruby

require 'bundler/setup'
require 'json'
require 'tyrano_dsl/main'
require 'tyrano_dsl/tyrano_exception'
if ARGV.length != 2
  raise 'You need two arguments : the path to the tyrano project and the path to your DSL file'
end
tyrano_project_path = ARGV[0]
dsl_file_path = ARGV[1]

builder_configuration_file = File.join(tyrano_project_path, 'builder_config.json')
unless File.exists? builder_configuration_file
  raise "File not found [#{builder_configuration_file}]"
end

writing_context = TyranoDsl::Main.new.run(dsl_file_path)
writing_context.file_actions.each do |file_action|
  file_action.run(tyrano_project_path)
end
