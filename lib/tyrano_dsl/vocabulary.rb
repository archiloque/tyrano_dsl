module TyranoDsl

  # All the available words of the DSL
  # @!macro [new] word_declare_background
  #   Declare a background
  # @!macro [new] word_declare_character
  #   Declare a character
  # @!macro [new] word_display_text
  #   Display some text
  # @!macro [new] word_jump_to
  #   Jump to a scene
  # @!macro [new] word_set_background
  #   Set the current background
  # @!macro [new] word_set_character_stance
  #   Set the stance of a character
  # @!macro [new] word_show_character
  #   Show a character
  # @!macro [new] word_start_scene
  #   Start a scene
  module Vocabulary

    # @!macro word_declare_background
    DECLARE_BACKGROUND = 'declare_background'.freeze
    # @!macro word_declare_character
    DECLARE_CHARACTER = 'declare_character'.freeze
    # @!macro word_display_text
    DISPLAY_TEXT = 'display_text'.freeze
    # @!macro word_jump_to
    JUMP_TO = 'jump_to'.freeze
    # @!macro word_set_background
    SET_BACKGROUND = 'set_background'.freeze
    # @!macro word_set_character_stance
    SET_CHARACTER_STANCE = 'set_character_stance'.freeze
    # @!macro word_show_character
    SHOW_CHARACTER = 'show_character'.freeze
    # @!macro word_start_scene
    START_SCENE = 'start_scene'.freeze

    # All the available words
    ALL_WORDS = [
        DECLARE_BACKGROUND,
        DECLARE_CHARACTER,
        DISPLAY_TEXT,
        JUMP_TO,
        SET_BACKGROUND,
        SET_CHARACTER_STANCE,
        SHOW_CHARACTER,
        START_SCENE
    ].sort.freeze
  end
end