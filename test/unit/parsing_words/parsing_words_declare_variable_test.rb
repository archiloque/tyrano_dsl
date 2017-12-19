require_relative 'parsing_words_test_helper'

class ParsingWordsDeclareVariableTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_duplicated_variable
    parser = create_parser
    declare_variable(parser.context.world, 'variable', 1)
    begin
      parser.declare_variable('variable', 10)
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ duplicated variable \[variable\]/, e.message)
    end
  end

  def test_ok
    parser = create_parser
    parser.declare_variable('variable', 12)
    assert_equal(parser.context.world.variables.length, 1)
    assert_equal(parser.context.world.variables.keys.first, 'variable')
    variable = parser.context.world.variables.values.first
    assert_equal(variable.name, 'variable')
    assert_equal(variable.target_name, 'variable_1')
    assert_equal(variable.initial_value, 12)
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::DECLARE_VARIABLE)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, :variable_name => 'variable', :initial_value => 12)
  end

end
