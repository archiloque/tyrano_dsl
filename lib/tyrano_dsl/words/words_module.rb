require_relative '../tyrano_exception'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # Helpers to write words
    # @!macro [new] word_parse
    #   Parse a word
    #   @param context [TyranoDsl::ParsingContext] context
    #   @param [Thread::Backtrace::Location] word_location
    #   @param parameters [Array]
    #   @return [void]
    #   @raise [TyranoDsl::TyranoException]
    module WordsModule

      # @param [Thread::Backtrace::Location] word_location
      # @param [Array<String>] expected_parameters_names
      # @param [Array] parameters
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def validate_parameters_length(word_location, expected_parameters_names, parameters)
        if expected_parameters_names.length != parameters.length
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} you should have #{expected_parameters_names.length} parameter(s) specifying #{expected_parameters_names.join(', ')} but you have #{parameters.length} parameters : #{parameters}"
        end
      end

      # @param [Thread::Backtrace::Location] word_location
      # @param [String] image_path
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def validate_image_exist(word_location, image_path)
        unless File.exist?(image_path)
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} missing file [#{image_path}]"
        end
      end

      # @param [TyranoDsl::ParsingContext] parsing_context
      # @param [Thread::Backtrace::Location] word_location
      # @param [String] character_name
      # @param [String, nil] character_stance
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def check_character_exist(parsing_context, word_location, character_name, character_stance = nil)
        character = parsing_context.world.characters[character_name]
        unless character
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} unknown character [#{character_name}], currently defined: #{world.characters.keys.sort.join(', ')}"
        end
        if character_stance
          unless character.stances.key? character_stance
            raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} unknown stance [#{character_stance}], currently defined: #{character.stances.keys.sort.join(', ')}"
          end
        end
      end

    end
  end
end
