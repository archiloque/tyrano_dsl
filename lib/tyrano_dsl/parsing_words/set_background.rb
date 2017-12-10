require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module SetBackground

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] background_name
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def set_background(background_name)
        unless context.world.backgrounds.key? background_name
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown background [#{background_name}], currently defined: #{context.world.backgrounds.keys.sort.join(', ')}"
        end
        add_parsed_word(
            TyranoDsl::Vocabulary::SET_BACKGROUND,
            name: background_name
        )
      end
    end
  end
end
