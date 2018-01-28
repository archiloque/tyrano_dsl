require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::DisplayText < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, _world, parameters)
    character_name = parameters[:character_name]
    text = parameters[:text]
    character_part = character_name ? "##{character_name}\n" : ''
    context.append_content(
        "[tb_start_text mode=1]\n#{character_part}#{text}\n[_tb_end_text]\n"
    )

  end

end