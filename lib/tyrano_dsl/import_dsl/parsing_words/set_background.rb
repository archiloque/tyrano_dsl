module TyranoDsl::ImportDsl::ParsingWords::SetBackground

  # @param [String] background_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def set_background(background_name)
    unless context.world.backgrounds.key? background_name
      raise_unknown('background', background_name, context.world.backgrounds.keys)
    end
    add_parsed_word(
        TyranoDsl::Vocabulary::SET_BACKGROUND,
        name: background_name
    )
  end

end
