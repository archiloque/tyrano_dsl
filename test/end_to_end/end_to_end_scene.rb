declare_character 'Shinji',
                  'default' => '../assets/characters/shinji/default_stance.jpg',
                  'angry' => '../assets/characters/shinji/angry.png'

declare_background 'School', '../assets/backgrounds/school.jpg'
declare_variable 'sadness', 25
set_title_screen_background 'School'

start_scene 'First scene'
clear_messages
set_background 'School'
declare_label 'Label 1'
show_character 'Shinji', 'default', 434, 128
show_message_window
display_text nil, 'Hello!'
display_text 'Shinji', 'Hello!'
set_character_stance 'Shinji', 'angry'
hide_message_window
ask_question [
                 {
                     'text' => 'Yes !',
                     'left' => 200,
                     'top' => 200,
                     'scene' => 'Second scene'
                 },
                 {
                     'text' => 'No ""?',
                     'left' => 200,
                     'top' => 300,
                     'scene' => 'First scene$',
                     'label' => 'a label'
                 }
             ]
hide_character 'Shinji'
jump 'Second scene'

start_scene 'Second scene'
clear_messages
set_background 'School'

start_scene 'First scene$'
clear_messages
set_background 'School'
declare_label 'a label'
conditional_jump 'sadness', '<', 10, 'First scene$'
update_variable 'sadness', '+=', 20
include_file 'subdirectory/included_scene.rb'
declare_background 'Same School', '../assets/backgrounds/school.jpg'
jump 'First scene', 'Label 1'
