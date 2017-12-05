require_relative 'file_actions/create_file_action'
require_relative 'writers_module'

module TyranoDsl

  module Writers

    class SceneWriter

      include ::TyranoDsl::Writers::WritersModule

      # @param [!TyranoDsl::Elements::World] world
      # @param [!TyranoDsl::Elements::Scene] scene
      # @param [!Array<String>] content
      # @return [!Array]
      def write(world, scene, content)
        log{"Writing scene [#{scene.name}]"}
        text_content = "[_tb_system_call storage=system/_#{scene.target_name}.ks]\n#{content.join("\n")}\n"
        [
          ::TyranoDsl::Writers::FileActions::CreateFileAction.new(
                                                                    "#{scene.target_name}.ks",
                                                     text_content
          )
        ]
      end

    end
  end

end