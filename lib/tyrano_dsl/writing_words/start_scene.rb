require_relative 'writing_words_module'

module TyranoDsl
  module WritingWords

    # @!macro word_start_scene
    class StartScene

      include TyranoDsl::WritingWords::WritingWordsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        writing_context.init_new_scene(parameters[:name])
      end

    end
  end
end
