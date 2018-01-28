require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/ask_question'

class ExportTyranoWords::AsksQuestionTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @ask_question = TyranoDsl::ExportTyrano::Words::AskQuestion.new
  end

  def test_ok
    @context.init_new_scene 'scene'
    declare_scene(@world, 'Second scene')
    declare_scene(@world, 'Third scene')
    @ask_question.run(@context, @world, :possible_answers => [
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
    ])
    assert_equal([
                     '[glink color="black" storage="scene1" target="" size="20" x="200" y="200" text="Yes !"]
[glink color="black" storage="scene2" target="label_0" size="20" x="200" y="300" text="No &quot;&quot;?"]
[s]
'], @context.current_scene_content)
  end

end
