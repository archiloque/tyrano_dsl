require_relative '../../../lib/tyrano_dsl/parsing_context'
require_relative '../unit_test_helper'

module ParsingWordsTestHelper

  include UnitTestHelper

  protected

  # @return [TyranoDsl::Parser]
  def create_parser
    parsing_context = TyranoDsl::ParsingContext.new
    TyranoDsl::Parser.new(parsing_context, __FILE__)
  end

  def full_path(file_path)
    File.absolute_path(file_path, __dir__)
  end

end
