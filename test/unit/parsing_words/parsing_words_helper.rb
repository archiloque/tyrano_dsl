require_relative '../unit_test_helper'

module ParsingWordsHelper

  include UnitTestHelper

  protected

  # @return [TyranoDsl::Parser]
  def create_parser
    parsing_context = TyranoDsl::ParsingContext.new(File.dirname(__FILE__), __FILE__)
    TyranoDsl::Parser.new(parsing_context)
  end

end
