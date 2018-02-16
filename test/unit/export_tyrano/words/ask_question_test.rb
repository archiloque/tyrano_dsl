require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/ask_question'

class ExportTyranoWords::AskQuestionTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @ask_question = TyranoDsl::ExportTyrano::Words::AskQuestion.new
  end

  # TODO

end
