require_relative 'base_word'

class TyranoDsl::ExportTyrano::Words::ClearMessages < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, _world, _parameters)
    context.append_content(
        '[cm]'
    )
  end
end
