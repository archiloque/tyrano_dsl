require_relative 'tyrano_dsl'

# A parsed word
class TyranoDsl::ParsedWord

  # @return [Hash]
  attr_reader :parameters
  # @return [String]
  attr_reader :word
  # @return [Array<String>]
  attr_reader :word_location

  # @param [String] word
  # @param [Array<String>] word_location
  # @param [Hash] parameters
  def initialize(word, word_location, parameters)
    @word = word
    @word_location = word_location
    @parameters = parameters
  end

end
