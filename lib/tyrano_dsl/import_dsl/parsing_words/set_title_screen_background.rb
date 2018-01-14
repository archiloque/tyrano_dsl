module TyranoDsl::ImportDsl::ParsingWords::SetTitleScreenBackground

  # @param [String] background_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def set_title_screen_background(background_name)
    unless context.world.backgrounds.key? background_name
      raise_unknown('background', background_name, context.world.backgrounds.keys)
    end
    if context.world.title_screen.background
      raise TyranoDsl::TyranoException, 'Title screen background already defined'
    end
    context.world.title_screen.background = background_name
    add_parsed_word(
        TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND,
        name: background_name
    )
  end

end
