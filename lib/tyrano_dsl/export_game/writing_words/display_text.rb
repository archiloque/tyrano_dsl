require_relative 'writing_words_module'

class TyranoDsl::ExportGame::WritingWords::DisplayText

  def run(writing_context, world, word_location, parameters)
    character_name = parameters[:character_name]
    text = parameters[:text]
    character_part = character_name ? "##{character_name}\n" : ''
    writing_context.append_content(
        word_location,
        "[tb_start_text mode=1]\n#{character_part}#{text}\n[_tb_end_text]\n"
    )

  end

end