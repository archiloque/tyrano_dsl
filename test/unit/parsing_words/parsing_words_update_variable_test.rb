require_relative 'parsing_words_test_helper'

class ParsingWordsUpdateVariableTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    declare_variable(parser.context.world, 'b', 20)
    parser.update_variable('a', '=', 'b')
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::UPDATE_VARIABLE)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, :variable => 'a', :operator => '=', :value => 'b')
  end

  def test_ok_value
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    parser.update_variable('a', '=', 20,)
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::UPDATE_VARIABLE)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, :variable => 'a', :operator => '=', :value => 20)
  end

  def test_unknown_variable
    parser = create_parser
    begin
      parser.update_variable('a', '=', 10)
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown variable \[a\], currently defined: /, e.message)
    end
  end

  def test_unknown_operator
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    begin
      parser.update_variable('a', '?', 10)
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown operator \[\?\]/, e.message)
    end
  end

  def test_unknown_value_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    begin
      parser.update_variable('a', '=', 'b')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown variable \[b\], currently defined: a/, e.message)
    end
  end

end
