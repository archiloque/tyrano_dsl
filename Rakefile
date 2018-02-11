require 'rake/testtask'
require 'bundler/gem_tasks'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

desc 'Run tests'
task :default => :test

def generate_word(word, relative_path)
  full_path = "lib/tyrano_dsl/#{relative_path}/#{word}.rb"
  p full_path
  if File.exists? full_path
    p "Already exists, skipping"
  else
    p "Creating"
    class_name = TyranoDsl::Vocabulary.full_class_name("#{relative_path}/#{word}")
    content = yield(class_name)
    IO.write(full_path, content)
  end
end

desc 'Generate words'
task :generate_words do
  relative_path = 'lib/tyrano_dsl/'
  require_relative 'lib/tyrano_dsl/vocabulary'
  TyranoDsl::Vocabulary::ALL_WORDS.each do |word|

    # export_dsl
    generate_word(word, 'export_dsl/words') do |class_name|
      <<-HEREDOC
require_relative 'plain_writing_word'

class #{class_name} < TyranoDsl::ExportDsl::Words::PlainWritingWord

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

    # export_tyrano
    generate_word(word, 'export_tyrano/words') do |class_name|
      <<-HEREDOC
require_relative 'base_word'

class #{class_name} < TyranoDsl::ExportTyrano::Words::BaseWord
  # TODO
end
      HEREDOC
    end

    # import_dsl
    generate_word(word, 'import_dsl/words') do |class_name|
      <<-HEREDOC
module #{class_name}

  def #{word.to_s}()
    # TODO
  end

end
      HEREDOC
    end

    # import_tyrano
    generate_word(word, 'import_tyrano/words') do |class_name|
      <<-HEREDOC
require_relative 'empty_word'

class #{class_name} < TyranoDsl::ImportTyrano::Words::EmptyWord

  def try_parsing(_context)
    # TODO
  end

end
      HEREDOC
    end

    # intermediate
    generate_word(word, 'intermediate/words') do |class_name|
      <<-HEREDOC
require_relative 'empty_word'

class #{class_name} < TyranoDsl::Intermediate::Words::EmptyWord

  # TODO

end
      HEREDOC
    end

  end
end