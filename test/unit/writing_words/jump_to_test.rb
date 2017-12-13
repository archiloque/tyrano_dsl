require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative '../../../lib/tyrano_dsl/writing_words/jump_to'

class JumpToTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name', 0)
    jump_to = TyranoDsl::WritingWords::JumpTo.new
    begin
      jump_to.run(writing_context, world, caller_locations, {scene_name: 'scene name', label_name: 'label_name'})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ this action should take place in a scene/, e.message
    end
  end

  def test_unknown_scene
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    jump_to = TyranoDsl::WritingWords::JumpTo.new
    begin
      jump_to.run(writing_context, world, caller_locations, {scene_name: 'scene name', label_name: 'label_name'})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ unknown scene \[scene name\], currently defined: /, e.message
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name', 0)
    jump_to = TyranoDsl::WritingWords::JumpTo.new
    jump_to.run(writing_context, world, caller_locations, {scene_name: 'scene name', label_name: 'label_name'})
    assert_equal writing_context.current_scene_content, ['[jump storage="scene0.ks" target="label_name"]']
  end


end