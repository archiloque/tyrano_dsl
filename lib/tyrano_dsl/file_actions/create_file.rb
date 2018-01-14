require_relative 'files_actions_module'

# Create a file with a custom content
class TyranoDsl::FileActions::CreateFile

  include TyranoDsl::FileActions::FileActionsModule

  # @return [String]
  attr_reader :content
  # @return [String]
  attr_reader :path

  # @param [String] path
  # @param [String] content
  def initialize(path, content)
    @path = path
    @content = content
    log {self.to_s}
  end

  # @param [String] tyrano_project_path
  # @return [void]
  def run(tyrano_project_path)
    full_path = File.join(tyrano_project_path, path)
    log {"Creating file [#{full_path}]"}
    create_parent_dir_if_not_exist(full_path)
    File.write(full_path, content)
  end

  def to_s
    "Create file [#{path}]"
  end

end
