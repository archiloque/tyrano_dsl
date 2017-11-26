#!/usr/bin/env ruby

require 'bundler/setup'
require 'tyrano_dsl/main'
if ARGV.length != 1
  raise 'You need one argument : the path to the tyrano project'
end
project_path = ARGV[0]
resulting_files = TyranoDsl::Main.new.run
resulting_files.each_pair do |filename, file_content|
  full_filename = File.expand_path(File.join(project_path, filename))
  p "Writing to [#{full_filename}]"
  File.write(full_filename, file_content)
end
