require 'pp'
require_relative 'words'

class TyranoDsl::ExportDsl::Words::BaseWord

  # @param [String] command
  # @param [Array<TyranoDsl::ExportDsl::Words::CallParameter>] call_parameters
  # @param [Hash{Symbol=>Object}] parameters
  # @return [String]
  def generate_call(command, call_parameters, parameters)
    result = "#{command}"
    last_present_parameters_number = call_parameters.rindex do |call_parameter|
      skippable_param?(call_parameter, parameters)
    end || call_parameters.length
    0.upto(last_present_parameters_number - 1) do |parameter_index|
      unless parameter_index == 0
        result << ','
      end

      call_parameter = call_parameters[parameter_index]
      parameter_value = parameters[call_parameter.name]

      if call_parameter.type.is_a? Array
        parameter_class = call_parameter.type.first do |possible_parameter_class|
          parameter_value.is_a? possible_parameter_class
        end
        if parameter_class
          result << (' ' + get_printable_value(parameter_value, parameter_class))
        else
          raise TyranoDsl::TyranoException, "Unknown type  for [#{parameter_value}] in #{call_parameter}"
        end
      elsif call_parameter.type.name == Hash.name && (parameter_index == last_present_parameters_number - 1)
        entries = []
        parameter_value.each_pair do |key, value|
          entries << "#{' ' * (command.length + 1)}#{print_value(key)} => #{print_value(value)}"
        end
        result << "\n#{entries.join(",\n")}"
      elsif call_parameter.type.name == Array.name
        entries = parameter_value.collect do |item|
          "#{' ' * (command.length + 5)}#{print_value(item)}"
        end
        result << " [\n#{entries.join(",\n")}\n#{' ' * (command.length + 1)}]"
      else
        result << (' ' + get_printable_value(parameter_value, call_parameter.type))
      end
    end

    result
  end

  # @param [String] command
  # @param [Array<TyranoDsl::ExportDsl::Words::CallParameter>] call_parameters
  # @param [TyranoDsl::ExportDsl::Context] context
  # @param [Hash] parameters
  # @return [void]
  def add_call_current_scene(command, call_parameters, context, parameters)
    context.append_content_current_scene(
        generate_call(
            command,
            call_parameters,
            parameters
        )
    )
  end

  private

  def print_value(value)
    if value.is_a? String
      value.inspect
    elsif value.is_a? Symbol
      value.to_s.inspect
    elsif value.is_a? Hash
      stringified_hash = {}
      value.each_pair do |k, v|
        if k.is_a? Symbol
          k = k.to_s
        end
        if v.is_a? Symbol
          v = v.to_s
        end
        stringified_hash[k] = v
      end
      pp stringified_hash
    else
      value
    end
  end

  # @param [TyranoDsl::ExportDsl::Words::CallParameter] call_parameter
  # @param [Hash{Symbol=>Object}] parameters
  # @return [TrueClass]
  def skippable_param?(call_parameter, parameters)
    if call_parameter.mandatory
      false
    else
      parameter_name = call_parameter.name
      if !parameters.key?(parameter_name)
        true
      elsif parameters[parameter_name].nil?
        true
      elsif parameters.key?(parameter_name) && (parameters[parameter_name] == call_parameter.default_value)
        true
      else
        false
      end
    end
  end

  # @param [Object] value
  # @param [Class] type
  # @return [String]
  def get_printable_value(value, type)
    case type.name
      when String.name
        return value.inspect
      when Integer.name
        return value.to_s
      when Float.name
        return value.to_s
      when Symbol.name
        return value.to_s.inspect
      else
        raise TyranoDsl::TyranoException, "Unknown type [#{type}]"
    end

  end
end
