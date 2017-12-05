require_relative 'actions_module'

module TyranoDsl
  module Actions

    # @!macro word_show_character
    class ShowCharacter

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        # @todo
      end
    end
  end
end
