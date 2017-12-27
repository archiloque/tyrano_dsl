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
          raise TyranoDsl::TyranoException, "Missing file [#{absolute_path}]"
        end
        absolute_path
      end

      # @param [TyranoDsl::ParsingContext] parsing_context
      # @param [String] variable_name
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def check_variable_exist(variable_name)
        unless context.world.variables.key?(variable_name)
          raise_unknown('variable', variable_name, context.world.variables.keys)
        end
      end

      # @param [String] character_name
      # @param [String, nil] character_stance
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def check_character_exist(character_name, character_stance = nil)
        character = context.world.characters[character_name]
        unless character
          raise_unknown('character', character_name, context.world.characters.keys)
        end
        if character_stance && !character.stances.key?(character_stance)
          raise_unknown('stance', character_stance, character.stances.keys)
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

      # @param [String] type
      # @param [String] unknown_name
      # @param [Array<String>] current_elements
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def raise_unknown(type, unknown_name, current_elements)
        raise TyranoDsl::TyranoException, "Unknown #{type} [#{unknown_name}], currently #{current_elements.length} defined: #{current_elements.sort.collect {|e| "[#{e}]"}.join(', ')}"
      end

    end
  end
end
