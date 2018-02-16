require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/declare_character'

class ExportTyranoWords::DeclareCharacterTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @declare_character = TyranoDsl::ExportTyrano::Words::DeclareCharacter.new
  end

  # TODO

end
