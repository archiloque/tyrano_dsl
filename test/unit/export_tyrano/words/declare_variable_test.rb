require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/declare_variable'

class ExportTyranoWords::DeclareVariableTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @declare_variable = TyranoDsl::ExportTyrano::Words::DeclareVariable.new
  end

  # TODO

end
