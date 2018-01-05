# TyranoDsl

[![Build Status](https://travis-ci.org/archiloque/tyrano_dsl.svg?branch=master)](https://travis-ci.org/archiloque/tyrano_dsl)
[![Gem Version](https://badge.fury.io/rb/tyrano_dsl.svg)](https://badge.fury.io/rb/tyrano_dsl)

A DSL to write visual novels games in Ruby using [TyranoBuilder](http://tyranobuilder.com).

TyranoBuilder is a good tool has many features like native web export but I don't like to click-heavy interface to write.

The goal is to provide a simple syntax you can use directly or you can build upon.

You create your TyranoBuilder project with the specific options and the library is used to modify the content without touching the other things.

The project is a WIP: I add things as I need them, if you have any issue or need something please ask me.

If you use it for a published VN, please tell me: it would make me happy and I'll add a link to it in this page.

Example:

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

## How to use it

- Install [TyranoBuilder](http://tyranobuilder.com)
- Create a project in it
- Install the gem
- Execute `tyrano-dsl export-game PATH_TO_YOUR_TYRANO_PROJECT PATH_TO_YOUR_RUBY_CODE.rb` in your project directory.

`PATH_TO_YOUR_TYRANO_PROJECT` should look like `/Users/u/Library/Application\ Support/Steam/steamapps/common/TyranoBuilder/myproject/Test`

If everything is OK it should update the files in your TyranoBuilder project.

You can then reopen the project in TyranoBuilder and see the changes.

If there is an error it should be displayed and the message should help you to fix the problem.

## Actions

* `export-game` export the game to replace the current content of the Tyrano project
* `export-text` export the text content of the game

## Current vocabulary

* [Background](#background)
  * [`declare_background` Declare a background](#declare_background)
  * [`set_background` Set the background](#set_background)
* [Characters](#characters)
  * [`declare_character` Declare a character](#declare_character)
  * [`hide_character` Hide a character](#hide_character)
  * [`set_character_stance` Change the stance of a character](#set_character_stance)
  * [`show_character` Show a character](#show_character)
* [Content](#content)
  * [`ask_question` Ask a question](#ask_question)
* [Jump &amp; Labels](#jump-labels)
  * [`declare_label` Declare a label](#declare_label)
  * [`conditional_jump` Jump to somewhere if a condition is met](#conditional_jump)
  * [`jump` Jump to somewhere](#jump)
* [Variables](#variables)
  * [`declare_variable` Declare a variable](#declare_variable)
  * [`update_variable` Update a variable](#update_variable)
* [Misc](#misc)
  * [`hide_message_window` Hide the message window](#hide_message_window)
  * [`include_file` Include a file](#include_file)
  * [`show_message_window` Show the message window](#show_message_window)
  * [`start_scene` Start a new scene](#start_scene)

<a id="background"></a>
### Background

<a id="declare_background"></a>
#### `declare_background` Declare a background

`declare_background(name, images_path)` 
- `name` is a `String` representing the background's name
- `images_path` is a `String` indicating the path to the background images

```ruby
declare_background 'School', 'background/school.jpg'
```

<a id="set_background"></a>
#### `set_background` Set the background

`show_background(name)` 
- `name` is a `String` representing the background's name

```ruby
set_background 'School'
```

<a id="characters"></a>
### Characters

<a id="declare_character"></a>
#### `declare_character` Declare a character

`declare_character(name, stances)`
- `name` is a `String` representing the character's name
- `stances` is a `Hash{String => String}` providing a list of stances with the path to their corresponding images

```ruby
declare_character 'Shinji', 
    'default' => 'default_stance.jpg',
    'angry' => 'angry.jpg'
```

<a id="hide_character"></a>
#### `hide_character` Hide a character

`hide_character(name)`
- `name` is a `String` representing the character's name

```ruby
hide_character 'Shinji'
```

<a id="set_character_stance"></a>
#### `set_character_stance` Change the stance of a character

`set_character_stance(name, stance)`
- `name` is a `String` representing the character's name
- `stance` is a `String` defining the stance name

```ruby
set_character_stance 'Shinji', 'angry'
```

<a id="show_character"></a>
#### `show_character` Show a character

`show_character(name, stance, left, top)`
- `name` is a `String` representing the character's name
- `stance` is a `String` defining the stance name
- `left` is an `Integer` defining the left position
- `top` is an `Integer` defining the top position

```ruby
show_character 'Shinji', 'default', 434, 128
```

<a id="content"></a>
### Content

<a id="ask_question"></a>
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

<a id="jump-labels"></a>
### Jump & Labels

<a id="declare_label"></a>
#### `declare_label` Declare a label

`declare_label(name)` 
- `name` is a `String` representing the label's name

```ruby
declare_label 'my label'
```

<a id="conditional_jump"></a>
#### `conditional_jump` Jump to somewhere if a condition is met

`conditional_jump(variable, operator, value, scene, label)`
- `variable` is a `String` indicating the name of the variable to be tested
- `operator` is a `String` indicating the comparison operator to use: `<`, `==` (equal), `>`, `!=` (different)
- `value` is a `String` or a `Float` indicating the thing to compare the variable to, it can be a numerical value or the name of another variable
- `scene` is a `String` indicating the name of the scene to jump to
- `label` (optional) is a `String` indicating the name of the label in the scene to jump to

```ruby
conditional_jump 'variable_1', '<', 10, 'Scene two'
conditional_jump 'variable_1', '=', 'variable_2', 'Scene two', 'Label three'
```

<a id="jump"></a>
#### `jump` Jump to somewhere

`jump(scene, label)`
- `scene` is a `String` indicating the name of the scene to jump to
- `label` (optional) is a `String` indicating the name of the label in the scene to jump to

```ruby
jump 'Scene two'
jump 'Scene two', 'Label three'
```

<a id="variables"></a>
### Variables

<a id="declare_variable"></a>
#### `declare_variable` Declare a variable

`declare_variable(variable_name, initial_value)` 
- `variable_name` is a `String` representing the variable name
- `initial_value` is a `Float` representing the variable initial value

```ruby
declare_variable 'happiness', 25
```

<a id="update_variable"></a>
#### `update_variable` Update a variable

`update_variable(variable_name, operation, value)` 
- `variable_name` is a `String` representing the variable name
- `operator` is a `String` indicating the operation to apply
  - `=` set the variable with the value
  - `+=` add the value to the variable
  - `-=` substract the value from the variable
  - `*=` multiply the value with the variable
  - `/=` divide the value with the variable
  - `%=` set the variable with the reminder of the division with the value
- `value` is a `String` or a `Float` indicating the thing to use as a value, it can be a numerical value or the name of another variable

```ruby
update_variable 'happiness', '=', 25
update_variable 'happiness', '+', 'calmness'
```

<a id="misc"></a>
### Misc

<a id="hide_message_window"></a>
#### `hide_message_window` Hide the message window

`hide_message_window`

```ruby
hide_message_window
```

<a id="include_file"></a>
#### `include_file` Include a file

`include_file(file_name)`
- `name` is a `file_name` representing the file to include

```ruby
include_file('other_scene.rb')
```

<a id="show_message_window"></a>
#### `show_message_window` Show the message window

`show_message_window`

```ruby
show_message_window
```

<a id="start_scene"></a>
#### `start_scene` Start a new scene

`start_scene(name)` 
- `name` is a `String` representing the scene's name

```ruby
start_scene 'First scene'
```

## How the thing works

The tool works like a two passes compiler:
- the first pass validates the syntax, the entry point is in `parser.rb`
- the second generate the content, the entry point is in `writer.rb`
- the content is applied to disk

## Links

- [the TyranoScript tags references](http://tyranobuilder.com/tyranoscript-tags-reference/)

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/archiloque/tyrano_dsl).

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The code is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

