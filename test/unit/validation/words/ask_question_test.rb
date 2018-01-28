require_relative '../../../../lib/tyrano_dsl/validation/words/ask_question'
require_relative 'words_base_test'

class ValidationWords::AskQuestionTest < ValidationWords::WordsBaseTest

  def setup
    super
    @ask_question = TyranoDsl::Validation::Words::AskQuestion.new
  end

  def test_missing_arg
    assert_tyrano_exception('Missing value for top') do
      @ask_question.world_construction_phase(
          @context,
          @world,
          caller,
          possible_answers:
              [
                  {
                      text: 'Yes !',
                      left: 200,
                      scene: 'Second scene'
                  }
              ]
      )
    end

    assert_tyrano_exception('Missing value for text') do
      @ask_question.world_construction_phase(
          @context,
          @world,
          caller,
          possible_answers:
              [
                  {
                      top: 200,
                      left: 200,
                      scene: 'Second scene'
                  }
              ]
      )
    end

    assert_tyrano_exception('Missing value for left') do
      @ask_question.world_construction_phase(
          @context,
          @world,
          caller,
          possible_answers:
              [
                  {
                      text: 'Yes !',
                      top: 200,
                      scene: 'Second scene'
                  }
              ]
      )
    end

    assert_tyrano_exception('Missing value for text') do
      @ask_question.world_construction_phase(
          @context,
          @world,
          caller,
          possible_answers:
              [
                  {
                      top: 200,
                      left: 200,
                      scene: 'Second scene'
                  }
              ]
      )
    end
  end

  def test_ok
    @ask_question.world_construction_phase(
        @context,
        @world,
        caller,
        possible_answers:
            [
                {
                    text: 'Yes !',
                    left: 200,
                    top: 200,
                    scene: 'Second scene'
                },
                {
                    text: 'No ""?',
                    left: 200,
                    top: 300,
                    scene: 'Third scene',
                    label: 'a label'
                }
            ])
    assert_equal(2, @world.jump_targets.length)
    first_jump_target = @world.jump_targets[0]
    assert_equal('Second scene', first_jump_target.scene)
    assert_nil first_jump_target.label
    second_jump_target = @world.jump_targets[1]
    assert_equal('Third scene', second_jump_target.scene)
  end

end
