require_relative '../../test_helper'

module ParsingWorldsHelper

  protected

  def create_parsing_context
    TyranoDsl::ParsingContext.new(File.dirname(__FILE__), __FILE__)
  end

end
