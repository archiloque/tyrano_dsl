require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/world'
require_relative '../../../lib/tyrano_dsl/elements_writers/title_screen_writer'

class TitleScreenWriterTest < Minitest::Test

  def test_no_background
    world = TyranoDsl::Elements::World.new('game.rb')
    title_screen_writer = TyranoDsl::ElementsWriters::TitleScreenWriter.new
    begin
      title_screen_writer.write(world)
      raise
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'No background defined for the title screen'
    end
  end

  def test_no_scene
    world = TyranoDsl::Elements::World.new('game.rb')
    title_screen_writer = TyranoDsl::ElementsWriters::TitleScreenWriter.new
    world.title_screen.background = 'background.png'
    begin
      title_screen_writer.write(world)
      raise
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'No scene defined'
    end

  end

  def test_ok

  end

end
