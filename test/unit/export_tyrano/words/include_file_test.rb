require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/include_file'

class ExportTyranoWords::IncludeFileTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @include_file = TyranoDsl::ExportTyrano::Words::IncludeFile.new
  end

  # TODO

end
