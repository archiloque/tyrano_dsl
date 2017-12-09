require_relative '../tyrano_exception'
require_relative '../vocabulary'

module TyranoDsl
  module ParsingWords

    module ParsingWordsModule

      protected

      # @param [String] image_path
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def validate_image_exist(image_path)
        unless File.exist?(File.join(context.base_path, image_path))
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} missing file [#{image_path}]"
        end
      end

      # @param [TyranoDsl::ParsingContext] parsing_context
      # @param [String] character_name
      # @param [String, nil] character_stance
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def check_character_exist(parsing_context, character_name, character_stance = nil)
        character = parsing_context.world.characters[character_name]
        unless character
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown character [#{character_name}], currently defined: #{world.characters.keys.sort.join(', ')}"
        end
        if character_stance && !character.stances.key?(character_stance)
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown stance [#{character_stance}], currently defined: #{character.stances.keys.sort.join(', ')}"
        end
      end

    end
  end
end
