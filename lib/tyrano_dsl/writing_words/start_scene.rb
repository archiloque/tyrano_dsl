require_relative 'writing_words_module'

class TyranoDsl::WritingWords::StartScene

  def run(writing_context, world, word_location, parameters)
    writing_context.init_new_scene(parameters[:name])
  end

end