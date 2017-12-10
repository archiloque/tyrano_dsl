require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_group 'Elements', 'elements/'
  add_group 'Elements writers', 'elements_writers/'
  add_group 'File actions', 'file_actions/'
  add_group 'Parsing words', 'parsing_words/'
  add_group 'Writing words', 'writing_words/'
end
require 'minitest/autorun'
