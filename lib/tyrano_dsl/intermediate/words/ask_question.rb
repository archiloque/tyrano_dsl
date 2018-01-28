require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::AskQuestion < TyranoDsl::Intermediate::Words::EmptyWord

  # @param [TyranoDsl::Intermediate::Context] _context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :possible_answers
  # @return [void]
  def world_construction_phase(_context, world, word_location, parameters)
    parameters[:possible_answers].each do |possible_answer|
      [:text, :left, :top, :scene].each do |param_name|
        unless possible_answer.key? param_name
          TyranoDsl::TyranoException.raise_exception "Missing value for #{param_name}", word_location
        end
      end
      scene_name = possible_answer[:scene]
      label_name = possible_answer[:label]
      world.jump_targets << TyranoDsl::Elements::JumpTarget.new(scene_name, label_name, word_location)
    end
  end

end