require_relative '../elements/background'
require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module DeclareLabel

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] label_name
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def declare_label(label_name)
        add_parsed_word(
            TyranoDsl::Vocabulary::DECLARE_LABEL,
            label_name: label_name
        )
      end
    end
  end
end
