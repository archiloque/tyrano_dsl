require 'fileutils'

require_relative 'files_actions_module'


# Direct copy of a file from a source to a destination
class TyranoDsl::ExportGame::FileActions::FileCopy

  include TyranoDsl::ExportGame::FileActions::FileActionsModule

  # @return [String]
  attr_reader :from_path
  # @return [String]
  attr_reader :to_path

  # @param [String] from_path
  # @param [String] to_path
  def initialize(from_path, to_path)
    @from_path = from_path
    @to_path = to_path
    log {self.to_s}
  end

  # @param [String] tyrano_project_path
  # @return [void]
  def run(tyrano_project_path)
    full_path = File.join(tyrano_project_path, to_path)
    log {"Copying file [#{from_path}] to [#{full_path}]"}
    create_parent_dir_if_not_exist(full_path)
    FileUtils.copy_file from_path, full_path
  end

  def to_s
    "Copy file [#{from_path}] to [#{to_path}]"
  end

end