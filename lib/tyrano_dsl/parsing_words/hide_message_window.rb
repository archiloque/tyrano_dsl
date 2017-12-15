require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module HideMessageWindow

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def hide_message_window
        add_parsed_word(
            TyranoDsl::Vocabulary::HIDE_MESSAGE_WINDOW,
        )
      end
    end
  end
end
