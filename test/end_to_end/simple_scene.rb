declare_character 'Shinji', 'characters/shinji',
                  'default' => 'default_stance.jpg',
                  'angry' => 'angry.png'

declare_background 'School', 'backgrounds/school.jpg'

start_scene 'First scene'
set_background 'School'
show_character 'Shinji', 'default'

display_text 'Shinji', 'Hello!'
set_character_stance 'Shinji', 'angry'
jump_to 'Second scene', ''

start_scene 'Second scene'
