#!/usr/bin/env ruby

require 'bundler/setup'
require 'json'
require 'tyrano_dsl/tyrano_exception'
if ARGV.length < 3
  raise 'You need at least three arguments : the import format, the export format, the import path and possibly the export path'
end

require 'tyrano_dsl/main'

main = TyranoDsl::Main.new(
    ARGV[0],
    ARGV[1],
    ARGV[2],
    (ARGV.length == 3) ? nil : ARGV[3]
)

main.apply_export
