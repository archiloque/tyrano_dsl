require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::Jump < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, _world, parameters)
    scene_name = parameters[:scene_name]
    label_name = parameters[:label_name]
    mangled_scene = context.mangled_scene_name(scene_name)
    mangled_label = label_name ? context.mangled_label_name(scene_name, label_name) : ''
    context.append_content(
        "[jump storage=\"#{mangled_scene}\.ks\" target=\"#{mangled_label}\"]"
    )
  end

end
