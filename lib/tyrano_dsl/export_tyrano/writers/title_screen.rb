require_relative '../../file_actions/create_file'
require_relative 'base_writer'

# Write the title screen
class TyranoDsl::ExportTyrano::Writers::TitleScreen < TyranoDsl::ExportTyrano::Writers::BaseWriter

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  def write(context, world)
    log {'Writing title screen'}
    background = get_background(world)
    first_scene = get_first_scene(world)

    content_text_content = title_screen_content(context, background, first_scene)
    preload_text_content = preload_text([context.backgrounds_long_file_names[background.name]])
    [
        TyranoDsl::FileActions::CreateFile.new(
            File.join('data', 'scenario', "title_screen.ks"),
            content_text_content
        ),
        TyranoDsl::FileActions::CreateFile.new(
            File.join('data', 'scenario', 'system', "_title_screen.ks"),
            preload_text_content
        )

    ]
  end

  private

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::Background] background
  # @param [TyranoDsl::Elements::Scene] first_scene
  # @return [String]
  def title_screen_content(context, background, first_scene)
    <<HEREDOC
[_tb_system_call storage=system/_title_screen.ks]

[hidemenubutton]

[tb_keyconfig  flag="0"  ]
[tb_hide_message_window  ]
[bg  storage="#{context.backgrounds_short_file_names[background.name]}"  ]
*title

[glink  text="New&nbsp;Game"  x="600"  y="370"  target="*start"  ]
[glink  text="Load&nbsp;Game"  x="600"  y="470"  target="*load"  ]
[s  ]
*start

[showmenubutton]

[cm]
[tb_keyconfig  flag="1"  ]
[jump  storage="#{context.mangled_scene_name(first_scene.name)}.ks"  target=""  ]
[s  ]
*load

[cm]
[showload]

[jump  target="*title"  storage=""  ]
[s  ]
HEREDOC
  end

  # @param [TyranoDsl::Elements::World] world
  # @return [TyranoDsl::Elements::Scene]
  def get_first_scene(world)
    first_scene_name = world.title_screen.first_scene_name
    unless first_scene_name
      raise TyranoDsl::TyranoException, 'No scene defined'
    end
    world.scenes[first_scene_name]
  end

  # @param [TyranoDsl::Elements::World] world
  # @return [TyranoDsl::Elements::Background]
  def get_background(world)
    background_name = world.title_screen.background
    unless background_name
      raise TyranoDsl::TyranoException, 'No background defined for the title screen'
    end
    world.backgrounds[background_name]
  end

end
