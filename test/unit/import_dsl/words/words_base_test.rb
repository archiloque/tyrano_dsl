require_relative '../../../../lib/tyrano_dsl/import_dsl/parser'
require_relative '../../../../lib/tyrano_dsl/import_dsl/context'
require_relative '../../unit_test_helper'

module ImportDslWords

  class WordsBaseTest < Minitest::Test

    include UnitTestHelper

    def setup
      @parser = create_parser
    end

    protected

    # @return [TyranoDsl::ImportDsl::Parser]
    def create_parser
      context = TyranoDsl::ImportDsl::Context.new
      TyranoDsl::ImportDsl::Parser.new(context, __FILE__)
    end

    # @param [String] file_path
    # @return [String]
    def full_path(file_path)
      File.absolute_path(file_path, __dir__)
    end

    # @param [String] word
    # @param [Hash] parameters
    # @return [void]
    def assert_word_equal(word, parameters)
      words = @parser.context.words
      assert_equal(1, words.length)
      assert_equal(word, words[0].word)
      assert_equal(parameters, words[0].parameters)
    end
  end
end
