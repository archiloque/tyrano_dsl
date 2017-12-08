require_relative '../file_actions/create_file_action'
require_relative 'elements_writers_module'

module TyranoDsl

  module ElementsWriters

    # Write things where all characters are implied
    class CharactersWriter

      include ::TyranoDsl::ElementsWriters::ElementsWritersModule

      # @param [TyranoDsl::Elements::World] world
      # @return [Array]
      def write(world)
        log {"Writing characters"}
        content = world.characters.values.collect do |character|
          file_name =
          "[chara_new name=\"#{character.name}\" jname=\"#{character.name}\" storage=\"chara\/#{character.default_stance_target_short_file_name}\"]\n"
        end.join()
        content += "[iscript]\n[endscript]\n"
        [
            TyranoDsl::FileActions::CreateFileAction.new(
                File.join('data', 'scenario', 'system', 'chara_define.ks'),
                content
            )
        ]
      end

    end
  end

end