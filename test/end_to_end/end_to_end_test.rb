require 'minitest/autorun'
require_relative '../../lib/tyrano_dsl/main'

class EndToEndTest < Minitest::Test

  Dir.glob(File.join(File.dirname(__FILE__), '*')).each do |f|
    if File.directory?(f)
      basename = File.basename(f)
      send :define_method, "test_#{basename}" do
        p "test_#{basename}"
        resulting_files = TyranoDsl::Main.new.run(File.join(f, 'in', TyranoDsl::Main::DEFAULT_FILENAME))
        p resulting_files
      end
    end
  end

  def test_english_hello
    assert_equal '1', '1'
  end

end