require_relative '../elements/character'

module TyranoDsl
  module WritingWords

    class SetCharacterStance

      def run(writing_context, world, word_location, parameters)
        character = world.characters[parameters[:name]]
        character_stance = parameters[:stance]

        writing_context.add_asset_loading(
            word_location,
            character.stances[character_stance].long_target_file_name
        )
        writing_context.append_content(
            word_location,
            "[chara_mod name=\"#{character.name}\" cross=\"true\" storage=\"#{character.stances[character_stance].short_target_file_name}\"]"
        )
      end

    end
  end
end
