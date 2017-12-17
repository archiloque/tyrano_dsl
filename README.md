# TyranoDsl

**PROJECT IS A WIP, NOT USABLE FOR THE MOMENT !**

A DSL to write visual novels games in Ruby using [TyranoBuilder](http://tyranobuilder.com).

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
show_message_window
display_text 'Shinji', 'Hello!'
set_character_stance 'Shinji', 'angry'
display_text nil, 'Do you want to go in the eva ?'
ask_question [
                 {
                     'text' => 'Yes!',
                     'left' => 200,
                     'top' => 200,
                     'scene' => 'Second scene'
                 },
                 {
                     'text' => 'No!',
                     'left' => 200,
                     'top' => 300,
                     'scene' => 'Third scene',
                     'label' => 'a label'
                 }
             ]
start_scene 'Second scene'
```

I add things as I need them for my needs, if you need something please ask me.  


## How to use it

- Install [TyranoBuilder](http://tyranobuilder.com)
- Create a project in it
- Install the gem
- Execute `tyrano-dsl PATH_TO_YOUR_TYRANO_PROJECT PATH_TO_YOUR_RUBY_CODE.rb` in your project directory.

`PATH_TO_YOUR_TYRANO_PROJECT` should look like `/Users/u/Library/Application\ Support/Steam/steamapps/common/TyranoBuilder/myproject/Test`

If everything is OK it should update the files in your TyranoBuilder project.

You can then reopen the project in TyranoBuilder and see the changes.

If there is an error it should be displayed and the message should help you to fix the problem.

## Current vocabulary

### Background

#### `declare_background` Declare a background

`declare_background(name, images_path)` 
- `name` is a `String` representing the background's name
- `images_path` is a `String` indicating the path to the background images

```ruby
declare_background 'School', 'background/school.jpg'
```

#### `set_background` Set the background

`show_background(name)` 
- `name` is a `String` representing the background's name

```ruby
set_background 'School'
```

### Characters

#### `declare_character` Declare a character

`declare_character(name, stances)`
- `name` is a `String` representing the character's name
- `stances` is a `Hash{String => String}` providing a list of stances with the path to their corresponding images

```ruby
declare_character 'Shinji', 
    'default' => 'default_stance.jpg',
    'angry' => 'angry.jpg'
```

#### `hide_character` Hide a character

`hide_character(name)`
- `name` is a `String` representing the character's name

```ruby
hide_character 'Shinji'
```

#### `set_character_stance` change the stance of a character

`set_character_stance(name, stance)`
- `name` is a `String` representing the character's name
- `stance` is a `String` defining the stance name

```ruby
set_character_stance 'Shinji', 'angry'
```

#### `show_character` show a character

`show_character(name, stance, left, top)`
- `name` is a `String` representing the character's name
- `stance` is a `String` defining the stance name
- `left` is an `Integer` defining the left position
- `top` is an `Integer` defining the top position

```ruby
show_character 'Shinji', 'default', 434, 128
```

### Content

#### `ask_question` Ask a question

`ask_question(possible_answers)`
- `possible_answers` is a list of possible answers with the corresponding target
  - `text` is a `String` representing the text of the answer
  - `left` is an `Integer` defining the left position 
  - `top` is an `Integer` defining the top position
  - `scene` is a `String` indicating the name of the scene to jump if the answer is selected
  - `label` (optional) is a `String` indicating the name of the label in the scene to jump if the answer is selected

  
```ruby
ask_question [
                 {
                     'text' => 'Yes',
                     'left' => 200,
                     'top' => 200,
                     'scene' => 'Second scene'
                 },
                 {
                     'text' => 'No',
                     'left' => 200,
                     'top' => 300,
                     'scene_name' => 'Third scene',
                     'label_name' => 'a label'
                 }
             ]
```

### Jump & Labels

#### `declare_label` Declare a label

`declare_label(name)` 
- `name` is a `String` representing the label's name

```ruby
declare_label 'my label'
```

#### `jump_to` Jump to a label

`jump_to(scene, label)`
- `scene` is a `String` indicating the name of the scene to jump to
- `label` (optional) is a `String` indicating the name of the label in the scene to jump to

```ruby
jump_to 'Scene two'
jump_to 'Scene two', 'Label three'
```

### Misc

#### `hide_message_window` Hide the message window

`hide_message_window`

```ruby
hide_message_window
```

#### `show_message_window` Show the message window

`show_message_window`

```ruby
show_message_window
```

#### `start_scene` Start a new scene

`start_scene(name)` 
- `name` is a `String` representing the scene's name

```ruby
start_scene 'First scene'
```

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

