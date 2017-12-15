module TyranoDsl
  module WritingWords

    class HideMessageWindow

      def run(writing_context, world, word_location, parameters)
        writing_context.append_content(
            word_location,
            '[tb_hide_message_window]'
        )
      end
    end
  end
end
