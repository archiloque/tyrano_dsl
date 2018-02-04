require_relative '../../elements/variable'
require_relative '../../file_actions/json_patch'
require_relative '../../tyrano_constants'
require_relative 'base_writer'

# Write variables
class TyranoDsl::ExportTyrano::Writers::Variables < TyranoDsl::ExportTyrano::Writers::BaseWriter

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  def write(context, world)
    log {'Writing variables'}
    variable_content = {}
    world.variables.values.each do |variable|
      variable_content[context.mangled_variable_name(variable.name)] = {
          :val => variable.initial_value ? variable.initial_value : '',
          :kind => 'f'
      }
    end
    [
        TyranoDsl::FileActions::JsonPatch.new(
            File.join(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE),
            [TyranoDsl::TyranoConstants::BUILDER_CONFIG_VARIABLE_PATH],
            variable_content
        )
    ]
  end

end
