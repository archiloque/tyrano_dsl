require_relative 'title_screen'

module TyranoDsl

  module Elements

    # A declared world
    # @attr [Hash{String => TyranoDsl::Elements::Scene}] scenes
    # @attr [Hash{String => TyranoDsl::Elements::Character}] characters
    # @attr [Hash{String => TyranoDsl::Elements::Background}] backgrounds
    # @attr [TyranoDsl::Elements::TitleScreen] title_screen
    class World

      attr_reader :scenes, :characters, :backgrounds, :title_screen

      def initialize(file_path)
        @scenes = {}
        @characters = {}
        @backgrounds = {}
        @file_path = file_path
        @title_screen = TyranoDsl::Elements::TitleScreen.new
      end

      def inspect
        "[#{@file_path}] #{scenes.length} scenes: #{scenes.values.collect {|s| "[#{s.name}]"}.join(', ')} #{characters.length} characters: #{characters.values.collect {|c| "[#{c.name}]"}.join(', ')} #{backgrounds.length} backgrounds: #{backgrounds.values.collect {|b| "[#{b.name}]"}.join(', ')}"
      end
    end

  end
end