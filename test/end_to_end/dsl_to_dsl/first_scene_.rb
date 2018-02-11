clear_messages
set_background "School"
declare_label "a label"
conditional_jump "sadness", "<", 10, "First scene$"
update_variable "sadness", "+=", 20
display_text nil, "Hello from included scene!"
set_background "Alice"
jump "First scene", "Label 1"