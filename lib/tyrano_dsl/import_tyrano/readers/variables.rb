require 'json'

require_relative '../../tyrano_constants'
require_relative 'base_reader'

# Read variables
class TyranoDsl::ImportTyrano::Readers::Variables < TyranoDsl::ImportTyrano::Readers::BaseReader

  # @param [TyranoDsl::ImportTyrano::FileAccessor] file_accessor
  # @return [Array<TyranoDsl::ParsedWord>]
  def read(file_accessor)
    log {"Reading variables from #{File.join(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE)}"}

    found_variables = {}

    builder_file = JSON.parse(file_accessor.read_file(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE))
    builder_file[TyranoDsl::TyranoConstants::BUILDER_CONFIG_VARIABLE_PATH].each_pair do |name, value|
      found_variables[name] = {
          value: value['val'],
          location: File.join(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE),
      }
    end

    line_index = 0
    file_accessor.read_file(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE).each_line do |line|
      if line.start_with? 'f[\''
        location = "#{File.join(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE)}:#{line_index}"
        if (match = line.match(/\Af\['(?<name>[^']+)'\]='';/))
          variable_name = match[:name]
          unless found_variables.key?(variable_name)
            found_variables[variable_name] = {
                value: nil,
                location: location,
            }
          end
        elsif (match = line.match(/\Af\['(?<name>[^']+)'\]='(?<value>[^']+)';/))
          variable_name = match[:name]
          variable_value = match[:value]
          found_variables[variable_name] = {
              value: variable_value,
              location: location,
          }
        elsif (match = line.match(/\Af\['(?<name>[^']+)'\]=(?<value>[\d]+);/))
          variable_name = match[:name]
          variable_value = match[:value]
          found_variables[variable_name] = {
              value: variable_value.to_i,
              location: location,
          }
        end
      end
      line_index += 1
    end

    found_variables.keys.sort.collect do |name|
      value = found_variables[name]
      TyranoDsl::ParsedWord.new(
          TyranoDsl::Vocabulary::DECLARE_VARIABLE,
          [value[:location]],
          variable_name: name,
          initial_value: value[:value],
          )
    end
  end

end
