require_relative 'writing_words_module'

module TyranoDsl
  module WritingWords

    # When a word has no action on the scene
    class Nop

      include TyranoDsl::WritingWords::WritingWordsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
      end

    end
  end
end
