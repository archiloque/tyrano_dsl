require_relative '../../file_actions/create_file'
require_relative '../../file_actions/json_patch'
require_relative '../../tyrano_constants'

require_relative 'base_writer'

# Write things where all characters are declared
class TyranoDsl::ExportTyrano::Writers::Characters < TyranoDsl::ExportTyrano::Writers::BaseWriter

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  def write(context, world)
    log {'Writing characters'}
    chara_define_content = ''
    world.characters.values.collect do |character|
      chara_define_content << "[chara_new name=\"#{character.name}\" jname=\"#{character.name}\" storage=\"chara\/#{context.stance_short_file_name(character.name, character.default_stance.name)}\"]\n"
    end
    chara_define_content << "\n"
    chara_define_content << "[iscript]\n"
    world.variables.values.each do |variable|
      if variable.initial_value.nil?
        initial_value = "''"
      elsif variable.initial_value.is_a? String
        initial_value = variable.initial_value.inspect
      else
        initial_value = variable.initial_value
      end
      chara_define_content << "f['#{context.mangled_variable_name(variable.name)}']=#{initial_value};\n"
    end
    chara_define_content << "[endscript]\n"

    builder_config_content = {}
    world.characters.values.each do |character|
      builder_config_content[character.name] = context.character_indexes[character.name]
    end

    [
        TyranoDsl::FileActions::CreateFile.new(
            File.join(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE),
            chara_define_content
        ),
        TyranoDsl::FileActions::JsonPatch.new(
            File.join(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE),
            [TyranoDsl::TyranoConstants::BUILDER_CONFIG_CHARACTERS_PATH],
            builder_config_content
        )
    ]
  end

end
