require_relative 'label'
require_relative 'title_screen'

module TyranoDsl

  module Elements

    # A declared world
    # @attr [Hash{String => TyranoDsl::Elements::Scene}] scenes
    # @attr [Hash{String => TyranoDsl::Elements::Character}] characters
    # @attr [Hash{String => TyranoDsl::Elements::Background}] backgrounds
    # @attr [Hash{String => TyranoDsl::Elements::Label}] labels
    # @attr [TyranoDsl::Elements::TitleScreen] title_screen
    # @attr [Array<TyranoDsl::Elements::JumpTarget>] jump_targets
    class World

      attr_reader :scenes, :characters, :backgrounds, :title_screen, :jump_targets, :labels

      def initialize(file_path)
        @scenes = {}
        @characters = {}
        @backgrounds = {}
        @labels = {}
        @jump_targets = []
        @file_path = file_path
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
          if jump_target.label.name && (!scene.labels.include?(jump_target.label.name))
            raise TyranoDsl::TyranoException, "Unknown label [#{jump_target.label.name}] declared in label"
          end
        end
      end

      def inspect
        "[#{@file_path}] #{scenes.length} scenes: #{scenes.values.collect {|s| "[#{s.name}]"}.join(', ')} #{characters.length} characters: #{characters.values.collect {|c| "[#{c.name}]"}.join(', ')} #{backgrounds.length} backgrounds: #{backgrounds.values.collect {|b| "[#{b.name}]"}.join(', ')}"
      end

      # @param [String|Nil] label_name
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

  end
end