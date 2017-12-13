declare_character 'Shinji',
                  'default' => '../assets/characters/shinji/default_stance.jpg',
                  'angry' => '../assets/characters/shinji/angry.png'

declare_background 'School', '../assets/backgrounds/school.jpg'

set_title_screen_background 'School'

start_scene 'First scene'
set_background 'School'
declare_label 'Label 1'
show_character 'Shinji', 'default', 434, 128

display_text 'Shinji', 'Hello!'
set_character_stance 'Shinji', 'angry'
hide_character 'Shinji'
jump_to 'Second scene'

start_scene 'Second scene'
set_background 'School'
