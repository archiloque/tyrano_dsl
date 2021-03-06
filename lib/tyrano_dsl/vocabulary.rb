require_relative 'tyrano_dsl'

# All the available words of the DSL
module TyranoDsl::Vocabulary

  # Declare a background
  ASK_QUESTION = :ask_question
  # Clear messages
  CLEAR_MESSAGES = :clear_messages
  # Conditional jump
  CONDITIONAL_JUMP = :conditional_jump
  # Declare a background
  DECLARE_BACKGROUND = :declare_background
  # Declare a character
  DECLARE_CHARACTER = :declare_character
  # Declare a label
  DECLARE_LABEL = :declare_label
  # Declare a variable
  DECLARE_VARIABLE = :declare_variable
  # Display some text
  DISPLAY_TEXT = :display_text
  # Hide a character
  HIDE_CHARACTER = :hide_character
  # Hide the message window
  HIDE_MESSAGE_WINDOW = :hide_message_window
  # Include another file
  INCLUDE_FILE = :include_file
  # Jump to a scene
  JUMP = :jump
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
  # Update a variable
  UPDATE_VARIABLE = :update_variable

  # All the available words
  ALL_WORDS = [
      ASK_QUESTION,
      CLEAR_MESSAGES,
      CONDITIONAL_JUMP,
      DECLARE_BACKGROUND,
      DECLARE_CHARACTER,
      DECLARE_LABEL,
      DECLARE_VARIABLE,
      DISPLAY_TEXT,
      HIDE_CHARACTER,
      HIDE_MESSAGE_WINDOW,
      INCLUDE_FILE,
      JUMP,
      SET_BACKGROUND,
      SET_TITLE_SCREEN_BACKGROUND,
      SET_CHARACTER_STANCE,
      SHOW_CHARACTER,
      SHOW_MESSAGE_WINDOW,
      START_SCENE,
      UPDATE_VARIABLE,
  ].sort.freeze

  # Get the word class corresponding to the words
  # @param [String] class_file_path name of the class
  def self.get_words_class(class_file_path)
    TyranoDsl::Vocabulary::ALL_WORDS.each do |word|
      full_path = "#{class_file_path}/#{word}"
      require_relative(full_path)
      class_name = self.full_class_name(full_path)
      word_class = Kernel.const_get(class_name)
      yield(word, word_class)
    end
  end

  def self.full_class_name(full_path)
     "TyranoDsl::" + full_path.
        split('_').
        collect(&:capitalize).
        join.
        split('/').
        collect do |c|
      c[0] = c[0].upcase
      c
    end.join('::')
  end
end