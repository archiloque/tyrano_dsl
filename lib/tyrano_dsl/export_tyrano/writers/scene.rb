require_relative '../../file_actions/create_file'
require_relative '../../tyrano_constants'
require_relative 'base_writer'

# Write a scene
class TyranoDsl::ExportTyrano::Writers::Scene < TyranoDsl::ExportTyrano::Writers::BaseWriter

  # @param [String] mangled_scene_name
  # @param [Array<String>] scene_content
  # @param [Array<String>] assets
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  def write(mangled_scene_name, scene_content, assets)
    log {"Writing scene [#{mangled_scene_name}]"}
    content_text_content = "[_tb_system_call storage=system/_#{mangled_scene_name}.ks]\n#{scene_content.join("\n")}\n"
    preload_text_content = preload_text(assets.to_a)
    [
        TyranoDsl::FileActions::CreateFile.new(
            File.join(* TyranoDsl::TyranoConstants::SCENE_DIRECTORY + ["#{mangled_scene_name}.ks"]),
            content_text_content
        ),
        TyranoDsl::FileActions::CreateFile.new(
            File.join(* TyranoDsl::TyranoConstants::SCENE_SYSTEM_DIRECTORY + ["_#{mangled_scene_name}.ks"]),
            preload_text_content
        )
    ]
  end

end
