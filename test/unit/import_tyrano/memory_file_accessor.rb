# Access files in memory

module ImportTyrano
  class MemoryFileAccessor

    # @param [Hash{String => String}] file_contents
    def initialize(file_contents)
      @file_contents = file_contents
    end

    # Read a file
    # @param [String] path
    # @return [String]
    def read_file(path)
      full_path = File.join(path)
      if @file_contents.key? full_path
        @file_contents[full_path]
      else
        raise "File not found [#{full_path}]"
      end
    end
  end

end