require_relative '../../elements/background'

module TyranoDsl::ImportDsl::Words::DeclareLabel

  # @param [String] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_label(label_name)
    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_LABEL,
        label_name: label_name
    )
  end

end
