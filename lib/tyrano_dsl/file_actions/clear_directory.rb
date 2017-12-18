require 'fileutils'

require_relative 'files_actions_module'

# Remove all files from a directory
# @attr [String] path
class TyranoDsl::FileActions::ClearDirectory

  include TyranoDsl::FileActions::FileActionsModule

  attr_reader :path

  # @param [String] path
  def initialize(path)
    @path = path
    log {to_s}
  end

  # @param [String] tyrano_project_path
  def run(tyrano_project_path)
    full_path = File.join(tyrano_project_path, path)
    log {"Cleaning [#{full_path}]"}
    if File.exists? full_path
      FileUtils.remove_entry full_path
    end
    FileUtils.mkdir_p full_path
  end

  def to_s
    "Clear directory [#{path}]"
  end

end
