require_relative 'eg_writing_words_helper'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/writing_words/ask_question'

class EGWritingWordsAsksQuestionTest < Minitest::Test

  include EGWritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    ask_question = TyranoDsl::ExportTyrano::WritingWords::AskQuestion.new
    assert_tyrano_exception('This action should take place in a scene') do
      ask_question.run(writing_context, world, caller, :possible_answers => [])
    end
  end

  def test_unknown_scene
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    ask_question = TyranoDsl::ExportTyrano::WritingWords::AskQuestion.new
    assert_tyrano_exception('Unknown scene [scene name], currently 0 defined: ') do
      ask_question.run(writing_context, world, caller, :possible_answers => [
          {
              :text => 'Yes !',
              :left => 200,
              :top => 200,
              :scene => 'scene name'
          }])
    end

    declare_scene(world, 'Second scene')
    assert_tyrano_exception('Unknown scene [scene name], currently 1 defined: [Second scene]') do
      ask_question.run(writing_context, world, caller, :possible_answers => [
          {
              :text => 'Yes !',
              :left => 200,
              :top => 200,
              :scene => 'scene name'
          }])
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'Second scene')
    declare_scene(world, 'Third scene')
    declare_label(world, 'a label')
    ask_question = TyranoDsl::ExportTyrano::WritingWords::AskQuestion.new
    ask_question.run(writing_context, world, caller, :possible_answers => [
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
[glink color="black" storage="scene1" target="label_0" size="20" x="200" y="300" text="No &quot;&quot;?"]
[s]
'], writing_context.current_scene_content)
  end

end
