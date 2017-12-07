require_relative 'actions_module'
require_relative '../elements/background'

module TyranoDsl
  module Actions

    # @!macro word_set_background
    class SetBackground

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        background = world.backgrounds[parameters[:name]]
        writing_context.append_content(
            word_location,
            "[bg  storage=\"#{background.target_file_name}\"  time=\"1000\"  ]"
        )
        writing_context.add_asset_loading(
            word_location,
            File.join(::TyranoDsl::Elements::Background::BACKGROUND_DIRECTORY, background.target_file_name)
        )
      end

    end
  end
end
