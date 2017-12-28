require 'logger'

require_relative 'parsed_word'
require_relative 'parsing_words/parsing_words_module'
require_relative 'tyrano_dsl'
require_relative 'tyrano_exception'
require_relative 'vocabulary'

# Parse the DSL
class TyranoDsl::Parser

  # @return [TyranoDsl::ParsingContext]
  attr_reader :context
  # @return [Array<String>]
  attr_accessor :word_location
  # @return [Array<String>]
  attr_reader :included_files_hierarchy

  include TyranoDsl::ParsingWords::ParsingWordsModule

  TyranoDsl::Vocabulary.get_words_class('parsing_words') do |word, word_module|
    include word_module

    # Patch the method to store the location when a word is called
    symbol_word = word.to_sym
    old_method = instance_method(symbol_word)
    define_method(symbol_word) do |*args|
      self.word_location = caller
      old_method.bind(self).call(*args)
    end
  end

  # @param [TyranoDsl::ParsingContext] parsing_context
  # @param [String] initial_file_path
  def initialize(parsing_context, initial_file_path)
    @context = parsing_context
    @logger = Logger.new(STDOUT)
    @included_files_hierarchy = [initial_file_path]
  end

  protected

  # Add a parsed word
  # @param [String] word
  # @param [Hash{String => Object}] parameters
  # @return [void]
  def add_parsed_word(word, parameters = {})
    context.words << TyranoDsl::ParsedWord.new(
        word,
        word_location,
        parameters
    )
  end

  private

  def log
    @logger.info(self.class) {yield}
  end

end