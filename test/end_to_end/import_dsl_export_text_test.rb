require_relative 'end_to_end_base_test'

class EndToEndTest::ImportDslExportTextTest < EndToEndTest::BaseTest

  def test_end_to_end
    content = run_on_file('end_to_end_scene.rb', 'dsl', 'text')
    assert_equal(
        [
            "Hello!\n",
            "Shinji\n",
            "Hello!\n",
            "  Yes !\n",
            "  No \"\"?\n",
            "Hello from included scene!\n",
        ], content)

  end

end