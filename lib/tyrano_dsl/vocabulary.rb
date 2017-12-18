module TyranoDsl

  # All the available words of the DSL
  module Vocabulary

    # Declare a background
    ASK_QUESTION = :ask_question
    # Declare a background
    DECLARE_BACKGROUND = :declare_background
    # Declare a character
    DECLARE_CHARACTER = :declare_character
    # Declare a label
    DECLARE_LABEL = :declare_label
    # Display some text
    DISPLAY_TEXT = :display_text
    # Hide a character
    HIDE_CHARACTER = :hide_character
    # Hide the message window
    HIDE_MESSAGE_WINDOW = :hide_message_window
    # Jump to a scene
    JUMP_TO = :jump_to
    # Set the current background
    SET_BACKGROUND = :set_background
    #  Set the background of the title screen
    SET_TITLE_SCREEN_BACKGROUND = :set_title_screen_background
    #  Set the stance of a character
    SET_CHARACTER_STANCE = :set_character_stance
    # Show a character
    SHOW_CHARACTER = :show_character
    # Show the message window
    SHOW_MESSAGE_WINDOW = :show_message_window
    # Start a scene
    START_SCENE = :start_scene

    # All the available words
    ALL_WORDS = [
        ASK_QUESTION,
        DECLARE_BACKGROUND,
        DECLARE_CHARACTER,
        DECLARE_LABEL,
        # DECLARE_VARIABLE,
        DISPLAY_TEXT,
        HIDE_CHARACTER,
        HIDE_MESSAGE_WINDOW,
        JUMP_TO,
        SET_BACKGROUND,
        SET_TITLE_SCREEN_BACKGROUND,
        SET_CHARACTER_STANCE,
        SHOW_CHARACTER,
        SHOW_MESSAGE_WINDOW,
        START_SCENE,
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