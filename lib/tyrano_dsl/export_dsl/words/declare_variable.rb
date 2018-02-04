require_relative 'call_parameter'
require_relative 'base_word'

class TyranoDsl::ExportDsl::Words::DeclareVariable < TyranoDsl::ExportDsl::Words::BaseWord

  CALL_PARAMETERS = [
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :variable_name,
          String
      ),
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :initial_value,
          String,
          false
      )
  ]

  CALL_PARAMETERS_FLOAT = [
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :variable_name,
          String
      ),
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :initial_value,
          Float,
          true
      )
  ]

  def run(context, parameters)
    if parameters[:initial_value].is_a? Float
      context.add_declaration(
          generate_call(
              TyranoDsl::Vocabulary::DECLARE_VARIABLE,
              CALL_PARAMETERS_FLOAT,
              parameters
          )
      )
    else
      context.add_declaration(
          generate_call(
              TyranoDsl::Vocabulary::DECLARE_VARIABLE,
              CALL_PARAMETERS,
              parameters
          )
      )
    end
  end

end