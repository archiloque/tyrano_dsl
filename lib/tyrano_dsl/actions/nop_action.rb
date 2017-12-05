require_relative 'actions_module'

module TyranoDsl
  module Actions

    # When a word has no action on the scene
    class NopAction

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
      end

    end
  end
end
