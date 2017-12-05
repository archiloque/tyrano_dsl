require_relative 'actions_module'

module TyranoDsl
  module Actions

    # @!macro word_set_background
    class SetBackground

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        background = world.backgrounds[parameters[:name]]
        writing_context.append_to_current_scene(
            word_location,
            [
                "[bg  storage=\"#{background.target_file_name}\"  time=\"1000\"  ]"
            ]
        )
      end

    end
  end
end
