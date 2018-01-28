require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::DeclareLabel < TyranoDsl::ExportTyrano::Words::BaseWord

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] _world
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :scene_name
  # @option parameters [String] :label_name
  def run(context, _world, parameters)
    scene_name = parameters[:scene_name]
    label_name = parameters[:label_name]
    label_value = context.mangled_label_name(scene_name, label_name)
    context.append_content(
        "*#{label_value}"
    )
  end

end
