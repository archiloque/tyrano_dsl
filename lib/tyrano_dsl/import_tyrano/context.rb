require_relative 'import_tyrano'

# Context for parsing, used by words to store content
class TyranoDsl::ImportTyrano::Context

  def initialize(directory_path)
    @directory_path = directory_path
  end

  # @param [String] file_path
  # @return [String]
  # @raise [TyranoDsl::TyranoException]
  def file_full_path(file_path)
    absolute_path = File.absolute_path(file_path, @directory_path)
    unless File.exist?(absolute_path)
      raise TyranoDsl::TyranoException, "Missing file [#{absolute_path}]"
    end
    absolute_path
  end

end