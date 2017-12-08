require_relative '../file_actions/create_file'
require_relative 'elements_writers_module'

module TyranoDsl

  module ElementsWriters

    # Write the title screen
    class TitleScreenWriter

      include TyranoDsl::ElementsWriters::ElementsWritersModule

      # @param [TyranoDsl::Elements::World] world
      # @return [Array]
      def write(world)
        log {'Writing title screen'}
        background = get_background(world)
        first_scene = get_first_scene(world)

        content_text_content = title_screen_content(background, first_scene)
        preload_text_content = preload_text([background.target_long_file_name])
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

      # @param [TyranoDsl::Elements::Background] background
      # @param [TyranoDsl::Elements::Scene] first_scene
      def title_screen_content(background, first_scene)
        <<HEREDOC
[_tb_system_call storage=system/_title_screen.ks]

[hidemenubutton]

[tb_keyconfig  flag="0"  ]
[tb_hide_message_window  ]
[bg  storage="#{background.target_short_file_name}"  ]
*title

[glink  text="New&nbsp;Game"  x="600"  y="370"  target="*start"  ]
[glink  text="Load&nbsp;Game"  x="600"  y="470"  target="*load"  ]
[s  ]
*start

[showmenubutton]

[cm  ]
[tb_keyconfig  flag="1"  ]
[jump  storage="#{first_scene.target_name}.ks"  target=""  ]
[s  ]
*load

[cm  ]
[showload]

[jump  target="*title"  storage=""  ]
[s  ]
HEREDOC
      end

      private

      # @param [TyranoDsl::Elements::World] world
      # @return [TyranoDsl::Elements::Scene]
      def get_first_scene(world)
        first_scene_name = world.title_screen.first_scene_name
        unless first_scene_name
          raise ::TyranoDsl::TyranoException, 'No scene'
        end
        world.scenes[first_scene_name]
      end

      # @param [TyranoDsl::Elements::World] world
      # @return [TyranoDsl::Elements::Background]
      def get_background(world)
        background_name = world.title_screen.background
        unless background_name
          raise ::TyranoDsl::TyranoException, 'No background defined for the title screen'
        end
        world.backgrounds[background_name]
      end

    end
  end

end