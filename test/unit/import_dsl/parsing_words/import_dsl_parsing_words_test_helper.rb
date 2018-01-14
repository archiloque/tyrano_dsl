require_relative '../../../../lib/tyrano_dsl/import_dsl/parser'
require_relative '../../../../lib/tyrano_dsl/import_dsl/parsing_context'
require_relative '../../unit_test_helper'

module ParsingWordsTestHelper

  include UnitTestHelper

  protected

  # @return [TyranoDsl::Parser]
  def create_parser
    parsing_context = TyranoDsl::ImportDsl::ParsingContext.new
    TyranoDsl::ImportDsl::Parser.new(parsing_context, __FILE__)
  end

  # @param [String] file_path
  # @return [String]
  def full_path(file_path)
    File.absolute_path(file_path, __dir__)
  end

  # @param [TyranoDsl::Parser] parser
  # @param [String] word
  # @param [Hash] parameters
  # @return [void]
  def assert_word_equal(word, parameters, parser)
    words = parser.context.words
    assert_equal(1, words.length)
    assert_equal(word, words[0].word)
    assert_equal(parameters, words[0].parameters)
  end

end
