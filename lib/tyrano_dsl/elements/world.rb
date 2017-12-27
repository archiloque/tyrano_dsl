require_relative 'elements_module'
require_relative 'label'
require_relative 'title_screen'
require_relative 'variable'

# The game world
class TyranoDsl::Elements::World

  # @return [Hash{String => TyranoDsl::Elements::Background}]
  attr_reader :backgrounds
  # @return [Hash{String => TyranoDsl::Elements::Character}]
  attr_reader :characters
  # @return [Array<TyranoDsl::Elements::JumpTarget>]
  attr_reader :jump_targets
  # @return [Hash{String => TyranoDsl::Elements::Label}]
  attr_reader :labels
  # @return [Hash{String => TyranoDsl::Elements::Scene}]
  attr_reader :scenes
  # @return [TyranoDsl::Elements::TitleScreen]
  attr_reader :title_screen
  # @return [Hash{String => TyranoDsl::Elements::Variable}]
  attr_reader :variables

  def initialize
    @characters = {}
    @backgrounds = {}
    @labels = {}
    @jump_targets = []
    @scenes = {}
    @variables = {}
    @title_screen = TyranoDsl::Elements::TitleScreen.new
  end

  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def validate
    @jump_targets.each do |jump_target|
      scene = @scenes[jump_target.scene]
      unless scene
        raise TyranoDsl::TyranoException, "Unknown scene [#{jump_target.scene}] declared in label"
      end
      jump_target_label = jump_target.label
      if jump_target_label && (!scene.labels.include?(jump_target_label.name))
        raise TyranoDsl::TyranoException, "Unknown label [#{jump_target_label.name}] declared in label"
      end
    end
  end

  # @param [String, nil] label_name
  # @return [TyranoDsl::Elements::Label]
  def label_value(label_name)
    if @labels.key? label_name
      @labels[label_name]
    else
      technical_name = label_name ? "label_#{@labels.length}" : nil
      label = TyranoDsl::Elements::Label.new(label_name, technical_name)
      @labels[label_name] = label
      label
    end
  end

end
