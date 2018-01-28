require 'logger'
require_relative 'files_actions'

class TyranoDsl::FileActions::BaseFileAction

  # @param [String] base_path
  # @return [void]
  def run(base_path)
    raise 'Should be implented in subclasses'
  end

  protected

  def create_parent_dir_if_not_exist(file_path)
    parent_dir = File.dirname(file_path)
    unless File.exists? parent_dir
      FileUtils.mkdir_p parent_dir
    end
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def log
    logger.info(self.class) {yield}
  end

end