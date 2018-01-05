#!/usr/bin/env ruby

require 'bundler/setup'
require 'json'
require 'tyrano_dsl/tyrano_exception'
if ARGV.length != 3
  raise 'You need three arguments : the verb to execute, the path to the tyrano project and the path to your DSL file'
end

EXPORT_GAME_COMMAND = 'export-game'
EXPORT_TEXT_COMMAND = 'export-text'

verb = ARGV[0]
unless [EXPORT_GAME_COMMAND, EXPORT_TEXT_COMMAND].include? verb
  raise "Unknown verb [#{verb}, should be [#{EXPORT_GAME_COMMAND}] or [#{EXPORT_TEXT_COMMAND}]"
end
tyrano_project_path = ARGV[1]
dsl_file_path = ARGV[2]

builder_configuration_file = File.join(tyrano_project_path, 'builder_config.json')
unless File.exists? builder_configuration_file
  raise "File not found [#{builder_configuration_file}]"
end

if verb == EXPORT_GAME_COMMAND
  require 'tyrano_dsl/export_game/main'
  main = TyranoDsl::ExportGame::Main.new
else
  require 'tyrano_dsl/export_text/main'
  main = TyranoDsl::ExportText::Main.new
end

result = main.run(dsl_file_path)
main.apply(result, tyrano_project_path)
