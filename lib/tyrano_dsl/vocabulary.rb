module TyranoDsl

  # All the available words of the DSL
  module Vocabulary

    # Declare a background
    DECLARE_BACKGROUND = 'declare_background'.freeze
    # Declare a character
    DECLARE_CHARACTER = 'declare_character'.freeze
    # Declare a characterlabel
    DECLARE_LABEL = 'declare_label'.freeze
    # Display some text
    DISPLAY_TEXT = 'display_text'.freeze
    # Jump to a scene
    JUMP_TO = 'jump_to'.freeze
    # Set the current background
    SET_BACKGROUND = 'set_background'.freeze
    #  Set the background of the title screen
    SET_TITLE_SCREEN_BACKGROUND = 'set_title_screen_background'.freeze
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
        DECLARE_LABEL,
        DISPLAY_TEXT,
        JUMP_TO,
        SET_BACKGROUND,
        SET_TITLE_SCREEN_BACKGROUND,
        SET_CHARACTER_STANCE,
        SHOW_CHARACTER,
        START_SCENE
    ].sort.freeze

    # Get the word class corresponding to the words
    # @param [String] class_file_path name of the class
    def self.get_words_class(class_file_path)
      TyranoDsl::Vocabulary::ALL_WORDS.each do |word|
        full_path = "#{class_file_path}/#{word}"
        require_relative full_path
        full_class_name = "TyranoDsl::" + full_path.
            split('_').
            collect(&:capitalize).
            join.
            split('/').
            collect do |c|
          c[0] = c[0].upcase
          c
        end.join('::')
        word_class = Kernel.const_get(full_class_name)
        yield(word, word_class)
      end
    end
  end
end