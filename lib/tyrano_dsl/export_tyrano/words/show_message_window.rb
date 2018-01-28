require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::ShowMessageWindow < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, _world, _parameters)
    context.append_content(
        '[tb_show_message_window]'
    )
  end

end
