require_relative 'actions_module'

module TyranoDsl
  module Actions

    # @!macro word_show_character
    class ShowCharacter

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        character = world.characters[parameters[:name]]
        writing_context.add_asset_loading(
            word_location,
            File.join(::TyranoDsl::Elements::Character::CHARACTER_DIRECTORY, character.images_dir, character.stances[parameters[:stance]])
        )

        # @todo
      end
    end
  end
end
