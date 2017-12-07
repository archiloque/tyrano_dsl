require_relative '../file_actions/create_file_action'
require_relative 'elements_writers_module'

module TyranoDsl

  module ElementsWriters

    # Write a scene
    class SceneWriter

      include TyranoDsl::ElementsWriters::ElementsWritersModule

      # @param [TyranoDsl::Elements::World] world
      # @param [TyranoDsl::Elements::Scene] scene
      # @param [Array<String>] content
      # @param [Array<String>] assets
      # @return [Array]
      def write(world, scene, content, assets)
        log {"Writing scene [#{scene.name}]"}
        content_text_content = "[_tb_system_call storage=system/_#{scene.target_name}.ks]\n#{content.join("\n")}\n"
        assets_text_content = assets.to_a.sort.collect {|a| "[preload storage=\"./data/#{a}\"]\n"}.join() + '[return]'
        [
            TyranoDsl::FileActions::CreateFileAction.new(
                "#{scene.target_name}.ks",
                content_text_content
            ),
            TyranoDsl::FileActions::CreateFileAction.new(
                File.join('system', "_#{scene.target_name}.ks"),
                assets_text_content
            )

        ]
      end

    end
  end

end