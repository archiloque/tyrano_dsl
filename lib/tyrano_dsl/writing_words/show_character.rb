module TyranoDsl
  module WritingWords

    class ShowCharacter

      def run(writing_context, world, word_location, parameters)
        character = world.characters[parameters[:name]]
        character_stance = parameters[:stance]
        left = parameters[:left]
        top= parameters[:top]
        writing_context.add_asset_loading(
            word_location,
            character.stances_target_long_files_names[character_stance]
        )
        writing_context.append_content(
            word_location,
            "[chara_show name=\"#{character.name}\" time=\"1000\" wait=\"true\" left=\"#{left}\" top=\"#{top}\" width=\"\" height=\"\" reflect=\"false\"]"
        )
      end
    end
  end
end
