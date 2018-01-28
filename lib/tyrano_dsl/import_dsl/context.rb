require_relative '../elements/world'
require_relative '../parsed_word'
require_relative '../tyrano_dsl'
require_relative 'import_dsl'

# Context for parsing, used by words to store content
class TyranoDsl::ImportDsl::Context

  # @return [Array<TyranoDsl::ParsedWord>]
  attr_reader :words

  def initialize
    @words = []
  end

end