require_relative 'actions_module'

module TyranoDsl
  module Actions

    # @!macro word_start_scene
    class StartScene

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        writing_context.init_new_scene(parameters[:name])
      end

    end
  end
end
