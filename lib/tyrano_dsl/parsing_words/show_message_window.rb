require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module ShowMessageWindow

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def show_message_window
        add_parsed_word(
            TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW,
        )
      end
    end
  end
end
