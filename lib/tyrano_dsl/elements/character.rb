module TyranoDsl

  module Elements

    class Character

      attr_reader :name
      attr_reader :expressions
      attr_reader :path

      def initialize(name, path, expressions)
        @name = name
        @path = path
        @expressions = expressions
      end

    end
  end

end