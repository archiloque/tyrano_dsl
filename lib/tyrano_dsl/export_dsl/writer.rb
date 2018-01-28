require_relative 'export_dsl'
require_relative 'writer'
require_relative 'context'

class TyranoDsl::ExportDsl::Writer

  def initialize
    @logger = Logger.new(STDOUT)
    @words = {}
    TyranoDsl::Vocabulary.get_words_class('export_dsl/words') do |word, word_class|
      @words[word] = word_class.new
    end
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [Array]
  # @raise [TyranoDsl::TyranoException]
  def run(world, parsed_words)
    log {'Writing content'}
    context = TyranoDsl::ExportDsl::Context.new(world)
    parsed_words.each do |parsed_word|
      action_word = @words[parsed_word.word]
      action_word.run(
          context,
          parsed_word.word_location,
          parsed_word.parameters
      )
    end
    context.end_writing
    context.file_actions
  end

  private

  def log
    @logger.info(self.class) {yield}
  end

end