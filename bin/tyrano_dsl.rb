#!/usr/bin/env ruby

require 'bundler/setup'
require 'json'
require 'tyrano_dsl/export_game/main'
require 'tyrano_dsl/tyrano_exception'
if ARGV.length != 3
  raise 'You need three arguments : the verb to execute, the path to the tyrano project and the path to your DSL file'
end
unless ARGV[0] != 'export-game'
  raise "Unknown verb [#{ARGV[0]}, should be [export-game]"
end
tyrano_project_path = ARGV[1]
dsl_file_path = ARGV[2]

builder_configuration_file = File.join(tyrano_project_path, 'builder_config.json')
unless File.exists? builder_configuration_file
  raise "File not found [#{builder_configuration_file}]"
end

main = TyranoDsl::ExportGame::Main.new
writing_context = main.run(dsl_file_path)
main.apply(writing_context, tyrano_project_path)
