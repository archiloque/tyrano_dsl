require_relative 'call_parameter'
require_relative 'base_word'

class TyranoDsl::ExportDsl::Words::DeclareBackground < TyranoDsl::ExportDsl::Words::BaseWord

  CALL_PARAMETERS = [
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :background_name,
          String
      ),
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :image_path,
          String
      )
  ]

  def run(context, parameters)
    background_name = parameters[:background_name]
    image_path = parameters[:image_path]
    target_image_path = context.image_file_name('backgrounds', "#{background_name}#{File.extname(image_path)}")
    context.add_declaration(
        generate_call(TyranoDsl::Vocabulary::DECLARE_BACKGROUND,
                      CALL_PARAMETERS,
                      {
                          background_name: background_name,
                          image_path: target_image_path
                      }
        )
    )
    context.add_file_copy(
        image_path,
        target_image_path
    )

  end

end