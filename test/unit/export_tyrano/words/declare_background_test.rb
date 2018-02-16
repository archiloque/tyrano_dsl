require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/declare_background'

class ExportTyranoWords::DeclareBackgroundTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @declare_background = TyranoDsl::ExportTyrano::Words::DeclareBackground.new
  end

  # TODO

end
