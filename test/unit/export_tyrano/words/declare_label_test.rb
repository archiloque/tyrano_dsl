require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/declare_label'

class ExportTyranoWords::DeclareLabelTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @declare_label = TyranoDsl::ExportTyrano::Words::DeclareLabel.new
  end

  # TODO

end
