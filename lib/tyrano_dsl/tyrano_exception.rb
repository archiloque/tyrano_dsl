require_relative 'tyrano_dsl'

# When something goes wrong.
class TyranoDsl::TyranoException < RuntimeError

  # @param [String] message
  # @param [Array<String>] word_location
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def self.raise_exception(message, word_location)
    exception = TyranoDsl::TyranoException.new(message)
    exception.set_backtrace word_location
    raise exception
  end


end
