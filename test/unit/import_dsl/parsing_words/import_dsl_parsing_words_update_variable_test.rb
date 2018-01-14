require_relative 'import_dsl_parsing_words_test_helper'

class ImportDslParsingWordsUpdateVariableTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    declare_variable(parser.context.world, 'b', 20)
    parser.update_variable('a', '=', 'b')
    assert_word_equal(
        TyranoDsl::Vocabulary::UPDATE_VARIABLE,
        {:variable => 'a', :operator => '=', :value => 'b'},
        parser
    )
  end

  def test_ok_value
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    parser.update_variable('a', '=', 20,)
    assert_word_equal(
        TyranoDsl::Vocabulary::UPDATE_VARIABLE,
        {:variable => 'a', :operator => '=', :value => 20},
        parser
    )
  end

  def test_unknown_variable
    parser = create_parser
    assert_tyrano_exception('Unknown variable [a], currently 0 defined: ') do
      parser.update_variable('a', '=', 10)
    end
  end

  def test_unknown_operator
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    assert_tyrano_exception('Unknown operator [?]') do
      parser.update_variable('a', '?', 10)
    end
  end

  def test_unknown_value_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    assert_tyrano_exception('Unknown variable [b], currently 1 defined: [a]') do
      parser.update_variable('a', '=', 'b')
    end
  end

end
