require_relative '../../test_helper'

module ParsingWorldsHelper

  protected

  # @return [TyranoDsl::Parser]
  def create_parser
    parsing_context = TyranoDsl::ParsingContext.new(File.dirname(__FILE__), __FILE__)
    TyranoDsl::Parser.new(parsing_context)
  end


end
