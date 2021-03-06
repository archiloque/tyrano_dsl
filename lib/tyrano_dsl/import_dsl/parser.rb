require 'logger'

require_relative '../parsed_word'
require_relative '../tyrano_exception'
require_relative '../vocabulary'
require_relative 'import_dsl'
require_relative 'context'
require_relative 'words/words'

# Parse the DSL
class TyranoDsl::ImportDsl::Parser

  # @return [TyranoDsl::ImportDsl::Context]
  attr_reader :context
  # @return [Array<String>]
  attr_accessor :word_location
  # @return [Array<String>]
  attr_reader :included_files_hierarchy

  include TyranoDsl::ImportDsl::Words

  TyranoDsl::Vocabulary.get_words_class('import_dsl/words') do |word, word_module|
    include word_module

    # Patch the method to store the location when a word is called
    symbol_word = word.to_sym
    old_method = instance_method(symbol_word)
    define_method(symbol_word) do |*args|
      self.word_location = caller
      old_method.bind(self).call(*args)
    end
  end

  # Parse a file
  # @param [String] initial_file_path
  # @return [TyranoDsl::ImportDsl::Context]
  # @raise [TyranoDsl::TyranoException]
  def self.parse(initial_file_path)
    context = TyranoDsl::ImportDsl::Context.new
    parser = TyranoDsl::ImportDsl::Parser.new(context, initial_file_path)
    parser.include_file(initial_file_path)
    context
  end

  # @param [TyranoDsl::ImportDsl::Context] context
  # @param [String] initial_file_path
  def initialize(context, initial_file_path)
    @context = context
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