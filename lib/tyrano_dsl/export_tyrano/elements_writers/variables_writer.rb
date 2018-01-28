require_relative '../../elements/variable'
require_relative '../../file_actions/json_patch'
require_relative 'base_elements_writers'

# Write a variable
class TyranoDsl::ExportTyrano::ElementsWriters::VariablesWriter < TyranoDsl::ExportTyrano::ElementsWriters::BaseElementsWriters

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [Array]
  def write(context, world)
    log {'Writing variables'}
    variable_content = {}
    world.variables.values.each do |variable|
      variable_content[context.mangled_variable_name(variable.name)] = {
          :val => variable.initial_value,
          :kind => 'f'
      }
    end
    [
        TyranoDsl::FileActions::JsonPatch.new(
            'builder_config.json',
            ['map_var'],
            variable_content
        )
    ]
  end

end
