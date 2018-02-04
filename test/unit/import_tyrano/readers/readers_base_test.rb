require_relative '../memory_file_accessor'

module ImportTyranoWriters

  class ReadersBaseTest < Minitest::Test

    protected

    # @param [Hash{String => String}] file_contents
    def create_file_accessor(file_contents)
      ImportTyrano::MemoryFileAccessor.new(file_contents)
    end

    # @param [TyranoDsl::ParsedWord] parsed_word
    # @param [String] word
    # @param [Hash] parameters
    # @return [void]
    def assert_word_equal(parsed_word, word, parameters)
      assert_equal(word, parsed_word.word)
      assert_equal(parameters, parsed_word.parameters)
    end

  end

end