require_relative 'elements/world'
require_relative 'parsed_word'
require_relative 'tyrano_dsl'

# Context for parsing, used by words to store content
class TyranoDsl::ParsingContext

  # @return [Array<TyranoDsl::ParsingContext::ParsedWord>]
  attr_reader :words
  # @return [String]
  attr_reader :base_path
  # @return [TyranoDsl::Elements::World]
  attr_reader :world

  def initialize(base_path, file_path)
    @base_path = base_path
    @words = []
    @world = TyranoDsl::Elements::World.new(file_path)
  end

  def inspect
    "#{@words.length} words, #{@world.inspect}"
  end

end