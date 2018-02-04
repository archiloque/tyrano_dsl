require_relative 'call_parameter'
require_relative 'base_word'

class TyranoDsl::ExportDsl::Words::PlainWritingWord < TyranoDsl::ExportDsl::Words::BaseWord

  def run(context, parameters)
    add_call_current_scene(
        word,
        call_parameters,
        context,
        parameters
    )

  end

end