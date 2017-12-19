require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/writing_words/ask_question'

class WritingWordsAsksQuestionTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    ask_question = TyranoDsl::WritingWords::AskQuestion.new
    begin
      ask_question.run(writing_context, world, caller_locations, :possible_answers => [])
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ this action should take place in a scene/, e.message)
    end
  end

  def test_unknown_scene
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    ask_question = TyranoDsl::WritingWords::AskQuestion.new
    begin
      ask_question.run(writing_context, world, caller_locations, :possible_answers => [
          {
              :text => 'Yes !',
              :left => 200,
              :top => 200,
              :scene => 'scene name'
          }])
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown scene \[scene name\], currently defined: /, e.message)
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'Second scene')
    declare_scene(world, 'Third scene')
    declare_label(world, 'a label')
    ask_question = TyranoDsl::WritingWords::AskQuestion.new
    ask_question.run(writing_context, world, caller_locations, :possible_answers => [
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
    assert_equal(writing_context.current_scene_content, [
        '[glink color="black" storage="scene1" target="" size="20" x="200" y="200" text="Yes !"]
[glink color="black" storage="scene1" target="label_0" size="20" x="200" y="300" text="No &quot;&quot;?"]
[s]
'])
  end

end
