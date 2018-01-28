require_relative 'call_parameter'
require_relative 'base_word'

class TyranoDsl::ExportDsl::Words::SetTitleScreenBackground < TyranoDsl::ExportDsl::Words::BaseWord

  CALL_PARAMETERS = [
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :background_name,
          String
      )
  ]

  def run(context, _word_location, parameters)
    context.add_declaration(
        generate_call(
            TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND,
            CALL_PARAMETERS,
            parameters
        )
    )
  end

end