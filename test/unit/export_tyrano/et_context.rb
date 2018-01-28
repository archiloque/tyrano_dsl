require_relative 'et_helper'

module ETContextHelper

  include ETHelper

  def test_character_images
    world = create_world
    declare_character(
        world,
        'Shinji',
        {
            'default' => 'stance/default.png',
            'angry' => 'stance/angry.jpg',
        })
    context = create_context(world)
    assert_equal 'todo', context.stance_short_file_name('Shinji', 'default')
    assert_equal 'todo', context.stance_long_file_name('Shinji', 'default')
    assert_equal 'todo', context.stance_short_file_name('Shinji', 'angry')
    assert_equal 'todo', context.stance_long_file_name('Shinji', 'default')
  end

end
