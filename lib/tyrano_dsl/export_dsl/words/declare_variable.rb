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
          Float
      )
  ]

  def run(context, _word_location, parameters)
    context.add_declaration(
        generate_call(
            TyranoDsl::Vocabulary::DECLARE_VARIABLE,
            CALL_PARAMETERS,
            parameters
        )
    )
  end

end