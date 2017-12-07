module TyranoDsl
  module WritingWords

    class ShowCharacter

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
