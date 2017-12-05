require_relative 'actions_module'

module TyranoDsl
  module Actions

    # @!macro word_set_character_stance
    class SetCharacterStance

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        # @todo
      end

    end
  end
end
