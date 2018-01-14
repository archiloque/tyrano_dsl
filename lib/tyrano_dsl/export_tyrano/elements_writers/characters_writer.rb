require_relative '../../file_actions/create_file'
require_relative '../../file_actions/json_patch'
require_relative 'elements_writers_module'

# Write things where all characters are implied
class TyranoDsl::ExportTyrano::ElementsWriters::CharactersWriter

  include TyranoDsl::ExportTyrano::ElementsWriters::ElementsWritersModule

  # @param [TyranoDsl::Elements::World] world
  # @return [Array]
  def write(world)
    log {'Writing characters'}
    chara_define_content = ''
    world.characters.values.collect do |character|
      chara_define_content << "[chara_new name=\"#{character.name}\" jname=\"#{character.name}\" storage=\"chara\/#{character.default_stance.short_target_file_name}\"]\n"
    end
    chara_define_content << "\n"
    chara_define_content << "[iscript]\n"
    world.variables.values.collect do |variable|
      chara_define_content << "f['#{variable.target_name}']=#{variable.initial_value};\n"
    end
    chara_define_content << "[endscript]\n"

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
            'builder_config.json',
            ['map_chara'],
            builder_config_content
        )
    ]
  end

end
