require_relative '../elements/world'
require_relative '../vocabulary'
require_relative 'context'
require_relative 'intermediate'

class TyranoDsl::Intermediate::Main

  WORDS_ONLY_IN_SCENE = [
      TyranoDsl::Vocabulary::ASK_QUESTION,
      TyranoDsl::Vocabulary::CLEAR_MESSAGES,
      TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
      TyranoDsl::Vocabulary::DECLARE_LABEL,
      TyranoDsl::Vocabulary::DISPLAY_TEXT,
      TyranoDsl::Vocabulary::HIDE_CHARACTER,
      TyranoDsl::Vocabulary::HIDE_MESSAGE_WINDOW,
      TyranoDsl::Vocabulary::JUMP,
      TyranoDsl::Vocabulary::SET_BACKGROUND,
      TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
      TyranoDsl::Vocabulary::SHOW_CHARACTER,
      TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW,
      TyranoDsl::Vocabulary::UPDATE_VARIABLE,
  ]

  def initialize
    @logger = Logger.new(STDOUT)
    @words = {}
    TyranoDsl::Vocabulary.get_words_class('intermediate/words') do |word, word_class|
      @words[word] = word_class.new
    end
  end

  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [TyranoDsl::Elements::World]
  # @raise [TyranoDsl::TyranoException]
  def run(parsed_words)
    world = TyranoDsl::Elements::World.new
    context = TyranoDsl::Intermediate::Context.new

    parsed_words.each do |parsed_word|
      word = parsed_word.word
      parameters = parsed_word.parameters

      if WORDS_ONLY_IN_SCENE.include?(word) && (!context.current_scene)
        TyranoDsl::TyranoException.raise_exception 'This action should take place in a scene', parsed_word.word_location
      end

      @words[word].world_construction_phase(
          context,
          world,
          parsed_word.word_location,
          parameters)
    end

    world.validate

    parsed_words.each do |parsed_word|
      word = parsed_word.word
      parameters = parsed_word.parameters
      @words[word].validation_phase(
          context,
          world,
          parsed_word.word_location,
          parameters)
    end

    world
  end

end