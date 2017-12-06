require_relative 'dsl_module'
require_relative '../vocabulary'

module TyranoDsl
  module Dsl

    # @!macro word_set_background
    module SetBackground

      include TyranoDsl::Dsl::DslModule

      # @param [String] background_name
      # @return [void]
      def set_background(background_name)
        unless context.world.backgrounds.key? background_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} unknown background [#{background_name}], currently defined: #{context.world.backgrounds.keys.sort.join(', ')}"
        end
        add_parsed_word(
            TyranoDsl::Vocabulary::SET_BACKGROUND,
            name: background_name
        )
      end
    end
  end
end
