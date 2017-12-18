require_relative '../file_actions/create_file'
require_relative 'elements_writers_module'

# Write a scene
class TyranoDsl::ElementsWriters::SceneWriter

  include TyranoDsl::ElementsWriters::ElementsWritersModule

  # @param [TyranoDsl::Elements::Scene] scene
  # @param [Array<String>] scene_content
  # @param [Array<String>] assets
  # @return [Array]
  def write(scene, scene_content, assets)
    log {"Writing scene [#{scene.name}]"}
    content_text_content = "[_tb_system_call storage=system/_#{scene.target_name}.ks]\n[cm]\n#{scene_content.join("\n")}\n"
    preload_text_content = preload_text(assets.to_a)
    [
        TyranoDsl::FileActions::CreateFile.new(
            File.join('data', 'scenario', "#{scene.target_name}.ks"),
            content_text_content
        ),
        TyranoDsl::FileActions::CreateFile.new(
            File.join('data', 'scenario', 'system', "_#{scene.target_name}.ks"),
            preload_text_content
        )

    ]
  end

end
