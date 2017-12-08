# TyranoDsl

**PROJECT IS A WIP, NOT USABLE FOR THE MOMENT !**

A DSL to generate TyranoBuilder games from Ruby.

The goal is to provide a simple syntax you can use directly or you can build upon. 

Example :

```ruby
declare_character 'Shinji', 
    'default' => 'default_stance.jpg',
    'angry' => 'angry.jpg'

declare_background 'School', 'background/school.jpg'

set_title_screen_background 'School'

start_scene 'First scene'
set_background 'School'
show_character 'Shinji', 'default', 434, 128

display_text 'Shinji', 'Hello!'
set_character_stance 'Shinji', 'angry'
jump_to 'Second scene'

start_scene 'Second scene'
```

I add things as I need them for my needs, if you need something please ask me.  


## How to use it

- Install the gem
- Execute `tyrano-dsl PATH_TO_YOUR_TYRANO_PROJECT` in your project directory.

`PATH_TO_YOUR_TYRANO_PROJECT` should look like `/Users/u/Library/Application\ Support/Steam/steamapps/common/TyranoBuilder/myproject/Test`

If everything is OK it should update the files in your TyranoBuilder project.

If there is an error it should be displayed and the message should help you to fix the problem.

# Current vocabulary

- `declare_background(name, images_path)` declare a scene 
  - `name` is a `String`
  - `images_path` is a `String` indicating the path to the background images
- `declare_character(name, stances)` declare a character
  - `name` is a `String`
  - `stances` is a `Hash{String => String}` providing a list of stances with the path to their corresponding images
- `jump_to(scene_name, label_name)` jump to a label
  - `scene_name` is a `String` indicating the name of the scene
  - `label_name` is a `String` indicating the name of the label in the scene (optional)
- `set_character_stance(name, stance)` change the stance of a character
  - `name` is a `String`
  - `stance` is a `String` defining the stance name
- `start_scene(name)` start a scene 
  - `name` is a `String`
- `show_character(namen, stance, left, top)` show a character
  - `name` is a `String`
  - `stance` is a `String` defining the stance name
  - `left` is an `Integer` defining the left position
  - `top` is an `Integer` defining the top position

## Default project organisation

- `content.rb` : the main content
- `backgrounds` : the backgrounds images
- `characters` : the characters images

## How the thing works

The tool works like a two passes compiler :
- the first pass validates the syntax, the entry point is in `parser.rb`
- the second generate the content, the entry point is in `writer.rb`
- the content is applied to disk

## Links

- http://tyranobuilder.com/tyranoscript-tags-reference/ : the TyranoScript tags references

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/archiloque/tyrano_dsl.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

