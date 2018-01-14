require_relative '../../../lib/tyrano_dsl/validation/validator'
require_relative '../../../lib/tyrano_dsl/parsed_word'
require_relative '../unit_test_helper'

class ValidatorTest < Minitest::Test

  include UnitTestHelper

  def test_duplicated_label
    world = TyranoDsl::Elements::World.new
    declare_scene(world, 'scene name')
    parsed_words = []
    parsed_words << create_word(
        TyranoDsl::Vocabulary::START_SCENE,
        name: 'scene name'
    )
    parsed_words << create_word(
        TyranoDsl::Vocabulary::DECLARE_LABEL,
        label_name: 'label name'
    )
    parsed_words << create_word(
        TyranoDsl::Vocabulary::DECLARE_LABEL,
        label_name: 'label name'
    )
    validator = TyranoDsl::Validation::Validator.new

    writing_context = TyranoDsl::ExportTyrano::WritingContext.new(world)
    writing_context.init_new_scene 'scene name'
    writing_context.add_label caller, 'label name'
    assert_tyrano_exception('Duplicated label [label name]') do
      validator.run(world, parsed_words)
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