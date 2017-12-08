declare_character 'Shinji',
                  'default' => 'characters/shinji/default_stance.jpg',
                  'angry' => 'characters/shinji/angry.png'

declare_background 'School', 'backgrounds/school.jpg'

set_title_screen_background 'School'

start_scene 'First scene'
set_background 'School'
show_character 'Shinji', 'default', 434, 128

display_text 'Shinji', 'Hello!'
set_character_stance 'Shinji', 'angry'
jump_to 'Second scene', ''

start_scene 'Second scene'
set_background 'School'
