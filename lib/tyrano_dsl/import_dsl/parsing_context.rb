require_relative '../elements/world'
require_relative '../parsed_word'
require_relative '../tyrano_dsl'
require_relative 'import_dsl'

# Context for parsing, used by words to store content
class TyranoDsl::ImportDsl::ParsingContext

  # @return [Array<TyranoDsl::ParsedWord>]
  attr_reader :words
  # @return [TyranoDsl::Elements::World]
  attr_reader :world

  def initialize
    @words = []
    @world = TyranoDsl::Elements::World.new
  end

end