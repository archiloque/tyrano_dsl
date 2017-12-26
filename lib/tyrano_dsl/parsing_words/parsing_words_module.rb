require_relative '../tyrano_exception'
require_relative '../vocabulary'

module TyranoDsl
  module ParsingWords

    module ParsingWordsModule

      protected

      # @param [String] file_path
      # @return [String]
      # @raise [TyranoDsl::TyranoException]
      def file_full_path(file_path)
        absolute_path = File.absolute_path(file_path, File.dirname(included_files_hierarchy.last))
        unless File.exist?(absolute_path)
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} missing file [#{absolute_path}]"
        end
        absolute_path
      end

      # @param [TyranoDsl::ParsingContext] parsing_context
      # @param [String] variable_name
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def check_variable_exist(variable_name)
        unless context.world.variables.key?(variable_name)
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown variable [#{variable_name}], currently defined: #{context.world.variables.keys.sort.join(', ')}"
        end
      end

      # @param [String] character_name
      # @param [String, nil] character_stance
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def check_character_exist(character_name, character_stance = nil)
        character = context.world.characters[character_name]
        unless character
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown character [#{character_name}], currently defined: #{context.world.characters.keys.sort.join(', ')}"
        end
        if character_stance && !character.stances.key?(character_stance)
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown stance [#{character_stance}], currently defined: #{character.stances.keys.sort.join(', ')}"
        end
      end

      # @param [Hash] hash
      # @return [Hash{Symbol=>Object}]
      def symbolize_keys(hash)
        result = {}
        hash.keys.each do |key|
          result[symbolize(key)] = hash[key]
        end
        result
      end

      # @param [String] string
      # @return [Symbol]
      def symbolize(string)
        string.to_sym rescue string
      end

    end
  end
end
