require_relative '../../../lib/tyrano_dsl/intermediate/main'
require_relative '../../../lib/tyrano_dsl/parsed_word'
require_relative '../unit_test_helper'

class IntermediateTest < Minitest::Test

  include UnitTestHelper

  def test_not_in_scene
    parsed_words = []
    parsed_words << create_word(
        TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW,
        scene_name: 'scene name'
    )
    validator = TyranoDsl::Intermediate::Main.new
    assert_tyrano_exception('This action should take place in a scene') do
      validator.run(parsed_words)
    end
  end

  def create_word(word, parameters)
    TyranoDsl::ParsedWord.new(
        word,
        [],
        parameters
    )
  end
end