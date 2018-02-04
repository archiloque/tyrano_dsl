require_relative '../../../../lib/tyrano_dsl/elements/world'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/writers/title_screen'
require_relative 'writers_base_test'

class ExportTyranoWriters::TitleScreenWriterTest < ExportTyranoWriters::WritersBaseTest

  def test_no_background
    world = create_world
    context = create_context(world)
    title_screen_writer = TyranoDsl::ExportTyrano::Writers::TitleScreen.new
    assert_tyrano_exception('No background defined for the title screen') do
      title_screen_writer.write(context, world)
    end
  end

  def test_no_scene
    world = create_world
    context = create_context(world)
    title_screen_writer = TyranoDsl::ExportTyrano::Writers::TitleScreen.new
    world.title_screen.background = 'background.png'
    assert_tyrano_exception('No scene defined') do
      title_screen_writer.write(context, world)
    end
  end

  def test_ok
    world = create_world
    context = create_context(world)
    title_screen_writer = TyranoDsl::ExportTyrano::Writers::TitleScreen.new
    world.title_screen.background = 'background 1'
    world.title_screen.first_scene_name = 'scene 1'
    declare_scene(world, 'scene 1')
    declare_background(world, 'background 1', 'background.png')
    context.after_setup
    create_files = title_screen_writer.write(context, world)
    assert_equal(2, create_files.length)
    assert_equal('data/scenario/title_screen.ks', create_files[0].path)
    assert_equal('[_tb_system_call storage=system/_title_screen.ks]

[hidemenubutton]

[tb_keyconfig  flag="0"  ]
[tb_hide_message_window  ]
[bg  storage="1.png"  ]
*title

[glink  text="New&nbsp;Game"  x="600"  y="370"  target="*start"  ]
[glink  text="Load&nbsp;Game"  x="600"  y="470"  target="*load"  ]
[s  ]
*start

[showmenubutton]

[cm  ]
[tb_keyconfig  flag="1"  ]
[jump  storage="scene1.ks"  target=""  ]
[s  ]
*load

[cm  ]
[showload]

[jump  target="*title"  storage=""  ]
[s  ]
', create_files[0].content)
    assert_equal('data/scenario/system/_title_screen.ks', create_files[1].path)
    assert_equal('[preload storage="./data/bgimage/1.png"]
[return]', create_files[1].content)
  end

end
