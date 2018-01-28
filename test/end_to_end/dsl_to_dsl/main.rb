declare_background "Alice", "backgrounds/alice.jpg"
declare_background "Same School", "backgrounds/same_school.jpg"
declare_background "School", "backgrounds/school.jpg"
declare_background "Shinji",
                   "default" => "characters/shinji/default.jpg",
                   "angry" => "characters/shinji/angry.png"
declare_variable "sadness", 25
set_title_screen_background "School"
include_file "first_scene.rb"
include_file "second_scene.rb"
include_file "first_scene_.rb"