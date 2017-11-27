declare_character 'Sabine', 'characters/sabine', {
    'default' => 'characters/sabine/default_stance.jpg',
    'angry' => 'characters/sabine/angry.jpg'
}
delare_background 'School', 'background/school.jpg'

declare_scene 'First scene'
set_background 'School'
show_character 'Sabine'

display_text 'Sabine', 'Hello!'
change_character_expression 'Sabine', 'angry'
