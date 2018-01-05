require_relative 'writing_words_module'

class TyranoDsl::ExportGame::WritingWords::HideMessageWindow

  def run(writing_context, world, word_location, parameters)
    writing_context.append_content(
        word_location,
        '[tb_hide_message_window]'
    )
  end

end