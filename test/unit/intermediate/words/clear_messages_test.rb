require_relative '../../../../lib/tyrano_dsl/intermediate/words/clear_messages'
require_relative 'words_base_test'

class IntermediateWords::ClearMessagesTest < IntermediateWords::WordsBaseTest

  def setup
    super
    @clear_messages = TyranoDsl::Intermediate::Words::ClearMessages.new
  end

  # TODO

end
