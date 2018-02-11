require_relative 'words'

module TyranoDsl::ExportDsl::Words

  # Represents a parameter in a call
  class CallParameter

    # @return [Symbol]
    attr_reader :name
    # @return [Class]
    attr_reader :type
    # @return [TrueClass]
    attr_reader :mandatory
    # @return [Object]
    attr_reader :default_value

    # @param [Symbol] name
    # @param [Class] type
    # @param [TrueClass|Nil] mandatory
    def initialize(name, type, mandatory = true, default_value = nil)
      @name = name
      @type = type
      @mandatory = mandatory
      @default_value = default_value
    end

  end
end
