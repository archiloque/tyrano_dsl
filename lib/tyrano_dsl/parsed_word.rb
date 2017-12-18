require_relative 'tyrano_dsl'

# A parsed word
# @attr [String] word
# @attr [Array<Thread::Backtrace::Location>] word_location
# @attr [Hash] parameters
class TyranoDsl::ParsedWord
  attr_reader :word, :word_location, :parameters

  # @param [String] word
  # @param [Array<Thread::Backtrace::Location>] word_location
  # @param [Hash] parameters
  def initialize(word, word_location, parameters)
    @word = word
    @word_location = word_location
    @parameters = parameters
  end

end
