require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class AskQuestionTest < Minitest::Test

  include ParsingWordsHelper

  def test_invalid_param
    parser = create_parser
    begin
      parser.ask_question(['plop'])
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ parameter is invalid/, e.message)
    end
  end

  def test_missing_arg
    parser = create_parser
    begin
      parser.ask_question(
          [
              {
                  'text' => 'Yes !',
                  'left' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ missing value for top/, e.message)
    end
    begin
      parser.ask_question(
          [
              {
                  'top' => 200,
                  'left' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ missing value for text/, e.message)
    end
    begin
      parser.ask_question(
          [
              {
                  'text' => 'Yes !',
                  'top' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ missing value for left/, e.message)
    end
    begin
      parser.ask_question(
          [
              {
                  'top' => 200,
                  'left' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ missing value for text/, e.message)
    end

  end

  def test_ok
    parser = create_parser
    parser.ask_question(
        [
            {
                'text' => 'Yes !',
                'left' => 200,
                'top' => 200,
                'scene' => 'Second scene'
            },
            {
                'text' => 'No ""?',
                'left' => 200,
                'top' => 300,
                'scene' => 'Third scene',
                'label' => 'a label'
            }
        ])
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::ASK_QUESTION)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, {
        :possible_answers => [
            {
                :text => 'Yes !',
                :left => 200,
                :top => 200,
                :scene => 'Second scene'
            },
            {
                text: 'No ""?',
                left: 200,
                top: 300,
                scene: 'Third scene',
                label: 'a label'
            }
        ]
    })
    assert_equal(parser.context.world.jump_targets.length, 2)
    first_jump_target = parser.context.world.jump_targets[0]
    assert_equal(first_jump_target.scene, 'Second scene')
    assert_nil first_jump_target.label
    second_jump_target = parser.context.world.jump_targets[1]
    assert_equal(second_jump_target.scene, 'Third scene')
    assert_equal(second_jump_target.label.name, 'a label')
  end

end
