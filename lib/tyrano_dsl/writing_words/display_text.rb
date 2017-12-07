module TyranoDsl
  module WritingWords

    class DisplayText

      def run(writing_context, world, word_location, parameters)
        character_name = parameters[:character_name]
        text = parameters[:text]
        writing_context.append_content(
            word_location,
            "[tb_start_text mode=1 ]\n##{character_name}\n#{text}\n[_tb_end_text]\n"
        )

      end

    end
  end
end
