require_relative '../../file_actions/create_file'
require_relative '../../file_actions/json_patch'
require_relative 'base_elements_writers'

# Write things where all characters are implied
class TyranoDsl::ExportTyrano::ElementsWriters::CharactersWriter < TyranoDsl::ExportTyrano::ElementsWriters::BaseElementsWriters

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [Array]
  def write(context, world)
    log {'Writing characters'}
    chara_define_content = ''
    world.characters.values.collect do |character|
      chara_define_content << "[chara_new name=\"#{character.name}\" jname=\"#{character.name}\" storage=\"chara\/#{context.stance_short_file_name(character.name, character.default_stance.name)}\"]\n"
    end
    chara_define_content << "\n"
    chara_define_content << "[iscript]\n"
    world.variables.values.collect do |variable|
      chara_define_content << "f['#{context.mangled_variable_name(variable.name)}']=#{variable.initial_value};\n"
    end
    chara_define_content << "[endscript]\n"

    builder_config_content = {}
    world.characters.values.each do |character|
      builder_config_content[character.name] = context.character_indexes[character.name]
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
