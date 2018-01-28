require_relative 'words_base_test'

class ImportDslWords::AskQuestionTest < ImportDslWords::WordsBaseTest

  def test_invalid_param
    assert_tyrano_exception('Parameter is not a Hash') do
      @parser.ask_question(['plop'])
    end
  end

  def test_ok
    @parser.ask_question(
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
            }]
    )
  end

end
