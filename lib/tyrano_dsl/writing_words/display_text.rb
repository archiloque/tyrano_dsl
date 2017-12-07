require_relative 'writing_words_module'

module TyranoDsl
  module WritingWords

    # @!macro word_display_text
    class DisplayText

      include TyranoDsl::WritingWords::WritingWordsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        # @todo
      end

    end
  end
end
