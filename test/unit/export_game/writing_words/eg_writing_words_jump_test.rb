require_relative 'eg_writing_words_helper'
require_relative '../../../../lib/tyrano_dsl/export_game/writing_words/jump'

class EGWritingWordsJumpTest < Minitest::Test

  include EGWritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_label(world, 'label name')
    jump = TyranoDsl::ExportGame::WritingWords::Jump.new
    assert_tyrano_exception('This action should take place in a scene') do
      jump.run(writing_context, world, caller, scene_name: 'scene name', label_name: 'label name')
    end
  end

  def test_unknown_scene
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_label(world, 'label name')
    jump = TyranoDsl::ExportGame::WritingWords::Jump.new
    assert_tyrano_exception('Unknown scene [scene name], currently 0 defined: ') do
      jump.run(writing_context, world, caller, scene_name: 'scene name', label_name: 'label name')
    end

    declare_scene(world, 'scene name')
    declare_label(world, 'label name')

    assert_tyrano_exception('Unknown scene [unknown scene], currently 1 defined: [scene name]') do
      jump.run(writing_context, world, caller, scene_name: 'unknown scene', label_name: 'label name')
    end
  end

  def test_ok_with_label
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_label(world, 'label name')
    jump = TyranoDsl::ExportGame::WritingWords::Jump.new
    jump.run(writing_context, world, caller, scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0"]'], writing_context.current_scene_content)
  end

  def test_ok_no_label
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    jump = TyranoDsl::ExportGame::WritingWords::Jump.new
    jump.run(writing_context, world, caller, scene_name: 'scene name', label_name: nil)
    assert_equal(['[jump storage="scene1.ks" target=""]'], writing_context.current_scene_content)
  end
end
