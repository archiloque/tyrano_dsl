require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_group 'Elements', 'elements/'

  add_group 'Export Game Elements writers', 'export_game/elements_writers/'
  add_group 'Export Game File actions', 'export_game/file_actions/'
  add_group 'Export Game Writing words', 'export_game/writing_words/'

  add_group 'Export Text', 'export_text/'

  add_group 'Parsing words', 'parsing_words/'
end

require 'minitest/autorun'
