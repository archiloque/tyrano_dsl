require_relative '../elements/character'
require_relative 'writing_words_module'

module TyranoDsl
  module WritingWords

    # @!macro word_set_character_stance
    class SetCharacterStance

      include TyranoDsl::WritingWords::WritingWordsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        character = world.characters[parameters[:name]]
        character_stance = parameters[:stance]
        writing_context.add_asset_loading(
            word_location,
            character.stances_target_long_files_names[character_stance]
        )
        # @todo
      end

    end
  end
end
