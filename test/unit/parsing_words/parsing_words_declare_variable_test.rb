require_relative 'parsing_words_test_helper'

class ParsingWordsDeclareVariableTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_duplicated_variable
    parser = create_parser
    declare_variable(parser.context.world, 'variable', 1)
    assert_tyrano_exception('Duplicated variable [variable]') do
      parser.declare_variable('variable', 10)
    end
  end

  def test_ok
    parser = create_parser
    parser.declare_variable('variable', 12)
    assert_equal(1, parser.context.world.variables.length)
    assert_equal('variable', parser.context.world.variables.keys.first)
    variable = parser.context.world.variables.values.first
    assert_equal('variable', variable.name)
    assert_equal('variable_1', variable.target_name)
    assert_equal(12, variable.initial_value)
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        {:variable_name => 'variable', :initial_value => 12},
        parser
    )
  end

end
