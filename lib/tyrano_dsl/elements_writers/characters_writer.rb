require_relative '../file_actions/create_file'
require_relative '../file_actions/json_patch'
require_relative 'elements_writers_module'

module TyranoDsl

  module ElementsWriters

    # Write things where all characters are implied
    class CharactersWriter

      include ::TyranoDsl::ElementsWriters::ElementsWritersModule

      # @param [TyranoDsl::Elements::World] world
      # @return [Array]
      def write(world)
        log {'Writing characters'}
        chara_define_content = world.characters.values.collect do |character|
          "[chara_new name=\"#{character.name}\" jname=\"#{character.name}\" storage=\"chara\/#{character.default_stance_target_short_file_name}\"]\n"
        end.join()
        chara_define_content << "[iscript]\n[endscript]\n"

        builder_config_content = {}
        world.characters.values.each do |character|
          builder_config_content[character.name] = character.index
        end

        [
            TyranoDsl::FileActions::CreateFile.new(
                File.join('data', 'scenario', 'system', 'chara_define.ks'),
                chara_define_content
            ),
            TyranoDsl::FileActions::JsonPatch.new(
                File.join('builder_config.json'),
                ['map_chara'],
                builder_config_content
            )

        ]


      end

    end
  end

end