set_background "School"
declare_label "Label 1"
show_character "Shinji", "default", 434, 128
show_message_window
display_text nil, "Hello!"
display_text "Shinji", "Hello!"
set_character_stance "Shinji", "angry"
hide_message_window
ask_question [
                 {"text"=>"Yes !", "left"=>200, "top"=>200, "scene"=>"Second scene"},
                 {"text"=>"No \"\"?", "left"=>200, "top"=>300, "scene"=>"First scene$", "label"=>"a label"}
             ]
hide_character "Shinji"
jump "Second scene"