require 'cgi'

require_relative '../../elements/world'
require_relative '../context'
require_relative 'words'

# An empty word
class TyranoDsl::ExportTyrano::Words::BaseWord

  # @param [TyranoDsl::ExportTyrano::Context] _context
  # @param [TyranoDSL::Elements::World] _world
  # @param [Hash{Symbol=>Object}] _parameters
  # @return [void]
  def run(_context, _world, _parameters)
  end

  protected

  # HTML escape text
  # @param [String] text
  # @return [String]
  def h(text)
    CGI::escapeHTML(text)
  end

end
