# TyranoDsl

**PROJECT IS A WIP, NOT USABLE FOR THE MOMENT !**

A DSL to generate TyranoBuilder games from human-readable ruby


Example :

```ruby
declare_project_path '/Users/u/Library/Application\ Support/Steam/steamapps/common/TyranoBuilder/myproject/Test'

declare_character 'Sabine', 'characters/sabine', {
    'default' => 'characters/sabine/default_stance.jpg',
    'angry' => 'characters/sabine/angry.jpg'
}
delare_background 'School', 'background/school.jpg'

declare_scene 'First scene'
set_background 'School'
show_character 'Sabine'

display_text 'Sabine', 'Hello!'
change_character 'Sabine', 'angry'
jump_to_scene 'Second scene'

declare_scene 'Second scene'

```

# Run

Execute `tyrano-dsl` in our project directory.

If everything is OK it should update the files in your TyranoBuilder project.

If there is an error it should be displayed.

# Project organisation

- `content.rb` : the main content
- `backgrounds` : the backgrounds images
- `characters` : the characters images

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/archiloque/tyrano_dsl.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

