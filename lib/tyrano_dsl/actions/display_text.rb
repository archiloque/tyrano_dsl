require_relative 'actions_module'

module TyranoDsl
  module Actions

    # @!macro word_display_text
    class DisplayText

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        # @todo
      end

    end
  end
end
