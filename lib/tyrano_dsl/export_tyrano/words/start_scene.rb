require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::StartScene < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, _world, parameters)
    context.init_new_scene(parameters[:scene_name])
  end

end