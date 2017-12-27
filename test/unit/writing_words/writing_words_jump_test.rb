require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/writing_words/jump'

class WritingWordsJumpTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_label(world, 'label name')
    jump = TyranoDsl::WritingWords::Jump.new
    assert_tyrano_exception('This action should take place in a scene') do
      jump.run(writing_context, world, caller, scene_name: 'scene name', label_name: 'label name')
    end
  end

  def test_unknown_scene
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_label(world, 'label name')
    jump = TyranoDsl::WritingWords::Jump.new
    assert_tyrano_exception('Unknown scene [scene name], currently 0 defined: ') do
      jump.run(writing_context, world, caller, scene_name: 'scene name', label_name: 'label name')
    end

    declare_scene(world, 'scene name')
    declare_label(world, 'label name')

    assert_tyrano_exception('Unknown scene [unknown scene], currently 1 defined: [scene name]') do
      jump.run(writing_context, world, caller, scene_name: 'unknown scene', label_name: 'label name')
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_label(world, 'label name')
    jump = TyranoDsl::WritingWords::Jump.new
    jump.run(writing_context, world, caller, scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0"]'], writing_context.current_scene_content)
  end

end
