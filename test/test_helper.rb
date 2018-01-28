require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_group 'Elements', 'elements/'
  add_group 'Export DSL', 'export_dsl/'
  add_group 'Export text', 'export_text/'
  add_group 'Export tyrano', 'export_tyrano/'
  add_group 'File actions', 'file_actions/'
  add_group 'Import DSL', 'import_dsl/'
  add_group 'Intermediate', 'intermediate/'
end

require 'minitest/autorun'
