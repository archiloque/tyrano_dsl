require_relative '../../elements/variable'
require_relative '../file_actions/json_patch'
require_relative 'elements_writers_module'

# Write a variable
class TyranoDsl::ExportTyrano::ElementsWriters::VariablesWriter

  include TyranoDsl::ExportTyrano::ElementsWriters::ElementsWritersModule

  # @param [TyranoDsl::Elements::World] world
  # @return [Array]
  def write(world)
    log {'Writing variables'}
    variable_content = {}
    world.variables.values.each do |variable|
      variable_content[variable.target_name] = {
          :val => variable.initial_value,
          :kind => 'f'
      }
    end
    [
        TyranoDsl::ExportTyrano::FileActions::JsonPatch.new(
            'builder_config.json',
            ['map_var'],
            variable_content
        )
    ]
  end

end
