module TyranoDsl

  # All the available words of the DSL
  module Vocabulary

    # Declare a background
    DECLARE_BACKGROUND = 'declare_background'.freeze
    # Declare a character
    DECLARE_CHARACTER = 'declare_character'.freeze
    # Display some text
    DISPLAY_TEXT = 'display_text'.freeze
    # Jump to a scene
    JUMP_TO = 'jump_to'.freeze
    # Set the current background
    SET_BACKGROUND = 'set_background'.freeze
    #  Set the stance of a character
    SET_CHARACTER_STANCE = 'set_character_stance'.freeze
    # Show a character
    SHOW_CHARACTER = 'show_character'.freeze
    # Start a scene
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