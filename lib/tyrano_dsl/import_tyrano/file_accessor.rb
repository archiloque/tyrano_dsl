require_relative 'import_tyrano'

# Access files, makes things easier to test
class TyranoDsl::ImportTyrano::FileAccessor

  # @param [String] directory_path path to the tyrano project
  def initialize(directory_path)
    @directory_path = directory_path
  end

  # Read a file
  # @param [Array<String>] path
  # @return [String]
  def read_file(path)
    IO.read(File.join(*([@directory_path] + path)))
  end

  # Read a file
  # @param [Array<String>] path
  # @return [Array<String>]
  def read_lines(path)
    IO.readlines(File.join(*([@directory_path] + path)))
  end

end