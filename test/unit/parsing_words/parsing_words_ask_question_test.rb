require_relative 'parsing_words_test_helper'

class ParsingWordsAskQuestionTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_invalid_param
    parser = create_parser
    assert_tyrano_exception('Parameter is not a Hash') do
      parser.ask_question(['plop'])
    end
  end

  def test_missing_arg
    parser = create_parser
    assert_tyrano_exception('Missing value for top') do
      parser.ask_question(
          [
              {
                  'text' => 'Yes !',
                  'left' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
    end

    assert_tyrano_exception('Missing value for text') do
      parser.ask_question(
          [
              {
                  'top' => 200,
                  'left' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
    end

    assert_tyrano_exception('Missing value for left') do
      parser.ask_question(
          [
              {
                  'text' => 'Yes !',
                  'top' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
    end

    assert_tyrano_exception('Missing value for text') do
      parser.ask_question(
          [
              {
                  'top' => 200,
                  'left' => 200,
                  'scene' => 'Second scene'
              }
          ]
      )
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
    assert_word_equal(
        TyranoDsl::Vocabulary::ASK_QUESTION,
        {:possible_answers => [
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
            }]},
        parser
    )

    assert_equal(2, parser.context.world.jump_targets.length)
    first_jump_target = parser.context.world.jump_targets[0]
    assert_equal('Second scene', first_jump_target.scene)
    assert_nil first_jump_target.label
    second_jump_target = parser.context.world.jump_targets[1]
    assert_equal('Third scene', second_jump_target.scene)
    assert_equal('a label', second_jump_target.label.name)
  end

end
