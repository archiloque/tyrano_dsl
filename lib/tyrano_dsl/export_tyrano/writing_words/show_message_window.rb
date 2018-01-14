require_relative 'writing_words_module'

class TyranoDsl::ExportTyrano::WritingWords::ShowMessageWindow

  def run(writing_context, world, word_location, parameters)
    writing_context.append_content(
        word_location,
        '[tb_show_message_window]'
    )
  end

end
