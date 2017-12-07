require_relative 'actions_module'
require_relative '../elements/character'

module TyranoDsl
  module Actions

    # @!macro word_set_character_stance
    class SetCharacterStance

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
