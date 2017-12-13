module TyranoDsl
  module WritingWords

    class HideCharacter

      def run(writing_context, world, word_location, parameters)
        character = world.characters[parameters[:name]]
        writing_context.append_content(
            word_location,
            "[chara_hide name=\"#{character.name}\" time=\"1000\" wait=\"true\"]"
        )
      end
    end
  end
end
