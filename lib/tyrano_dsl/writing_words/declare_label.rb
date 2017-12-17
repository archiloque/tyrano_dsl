module TyranoDsl
  module WritingWords

    class DeclareLabel

      def run(writing_context, world, word_location, parameters)
        label_name = parameters[:label_name]
        label = world.labels[label_name]
        writing_context.append_content(
            word_location,
            "*#{label.target_name}"
        )
        writing_context.add_label(
            word_location,
            label_name
        )
      end

    end
  end
end
