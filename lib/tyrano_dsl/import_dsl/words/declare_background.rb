require_relative '../../elements/background'

module TyranoDsl::ImportDsl::Words::DeclareBackground

  # @param [String] background_name
  # @param [String] image_path
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_background(background_name, image_path)
    image_full_path = file_full_path(image_path)
    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_BACKGROUND,
        background_name: background_name,
        image_path: image_full_path
    )
  end

end

