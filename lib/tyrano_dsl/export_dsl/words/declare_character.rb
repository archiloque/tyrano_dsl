require_relative 'call_parameter'
require_relative 'base_word'

class TyranoDsl::ExportDsl::Words::DeclareCharacter < TyranoDsl::ExportDsl::Words::BaseWord

  CALL_PARAMETERS = [
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :character_name,
          String
      ),
      TyranoDsl::ExportDsl::Words::CallParameter.new(
          :stances,
          Hash
      )
  ]

  def run(context, parameters)
    character_name = parameters[:character_name]
    character_name_dir = TyranoDsl::FileActions.sanitize_filename(character_name)

    local_images_stances = {}
    parameters[:stances].each_pair do |stance_name, stance_image|
      target_image_path = context.image_file_name(File.join('characters', character_name_dir), "#{stance_name}#{File.extname(stance_image)}")
      local_images_stances[stance_name] = target_image_path
      context.add_file_copy(
          stance_image,
          target_image_path
      )
    end
    context.add_declaration(
        generate_call(TyranoDsl::Vocabulary::DECLARE_BACKGROUND,
                      CALL_PARAMETERS,
                      {
                          character_name: character_name,
                          stances: local_images_stances
                      }
        )
    )

  end

end