module TyranoDsl
  module WritingWords

    class JumpTo

      def run(writing_context, world, word_location, parameters)
        scene_name = parameters[:scene_name]
        label_name = parameters[:label_name]
        target_scene = world.scenes[scene_name]
        unless target_scene
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown scene [#{scene_name}], currently defined: #{world.scenes.keys.sort.join(', ')}"
        end
        writing_context.append_content(
            word_location,
            "[jump storage=\"#{target_scene.target_name}\.ks\" target=\"#{label_name}\"]"
        )

      end

    end
  end
end
