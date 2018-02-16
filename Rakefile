require 'rake/testtask'
require 'bundler/gem_tasks'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

desc 'Run tests'
task :default => :test

def generate_word(word, relative_path, suffix = '')
  full_path = "#{relative_path}/#{word}#{suffix}.rb"
  p full_path
  if File.exists? full_path
    p "Already exists, skipping"
  else
    p "Creating"
    content = yield(word.to_s.split('_').collect(&:capitalize).join)
    IO.write(full_path, content)
  end
end

desc 'Generate words'
task :generate_words do
  relative_path = 'lib/tyrano_dsl/'
  require_relative 'lib/tyrano_dsl/vocabulary'
  TyranoDsl::Vocabulary::ALL_WORDS.each do |word|

    generate_word(word, 'lib/tyrano_dsl/export_dsl/words') do |camel_case_word|
      <<-HEREDOC
require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::#{camel_case_word} < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word
    TyranoDsl::Vocabulary::#{word.upcase}
  end

  def call_parameters
    # TODO
    []
  end

end
      HEREDOC
    end

    generate_word(word, 'lib/tyrano_dsl/export_tyrano/words') do |camel_case_word|
      <<-HEREDOC
require_relative 'base_word'

class TyranoDsl::ExportTyrano::Words::#{camel_case_word} < TyranoDsl::ExportTyrano::Words::BaseWord
  # TODO
end
      HEREDOC
    end

    generate_word(word, 'lib/tyrano_dsl/import_dsl/words') do |camel_case_word|
      <<-HEREDOC
module TyranoDsl::ImportDsl::Words::#{camel_case_word}

  def #{word.to_s}()
    # TODO
  end

end
      HEREDOC
    end

    generate_word(word, 'lib/tyrano_dsl/import_tyrano/words') do |camel_case_word|
      <<-HEREDOC
require_relative 'empty_word'

class TyranoDsl::ImportTyrano::Words::#{camel_case_word} < TyranoDsl::ImportTyrano::Words::EmptyWord

  def try_parsing(_context)
    # TODO
  end

end
      HEREDOC
    end

    generate_word(word, 'lib/tyrano_dsl/intermediate/words') do |camel_case_word|
      <<-HEREDOC
require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::#{camel_case_word} < TyranoDsl::Intermediate::Words::EmptyWord

  # TODO

end
      HEREDOC
    end

    generate_word(word, 'test/unit/export_dsl/words', '_test') do |camel_case_word|
      <<-HEREDOC
require_relative 'export_dsl_words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_dsl/words/#{word.to_s}'

class ExportDslWords::#{camel_case_word}Test < ExportDslWords::WordsBaseTest
  
  # TODO

end

      HEREDOC
    end

    generate_word(word, 'test/unit/export_tyrano/words', '_test') do |camel_case_word|
      <<-HEREDOC
require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/#{word.to_s}'

class ExportTyranoWords::#{camel_case_word}Test < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @#{word.to_s} = TyranoDsl::ExportTyrano::Words::#{camel_case_word}.new
  end

  # TODO

end
      HEREDOC
    end

    generate_word(word, 'test/unit/import_dsl/words', '_test') do |camel_case_word|
      <<-HEREDOC
require_relative 'words_base_test'

class ImportDslWords::#{camel_case_word}Test < ImportDslWords::WordsBaseTest

  # TODO

end
      HEREDOC
    end


    generate_word(word, 'test/unit/intermediate/words', '_test') do |camel_case_word|
      <<-HEREDOC
require_relative '../../../../lib/tyrano_dsl/intermediate/words/#{word.to_s}'
require_relative 'words_base_test'

class IntermediateWords::#{camel_case_word}Test < IntermediateWords::WordsBaseTest

  def setup
    super
    @#{word.to_s} = TyranoDsl::Intermediate::Words::#{camel_case_word}.new
  end

  # TODO

end
      HEREDOC
    end

  end
end