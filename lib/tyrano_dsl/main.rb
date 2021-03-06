require_relative 'tyrano_exception'
require_relative 'tyrano_dsl'
require_relative 'intermediate/main'

# The entry point
class TyranoDsl::Main

  attr_reader :export_result

  IMPORTS = {
      dsl: {
          path: 'import_dsl/main',
          class: 'TyranoDsl::ImportDsl::Main'
      },
      tyrano: {
          path: 'import_tyrano/main',
          class: 'TyranoDsl::ImportTyrano::Main'
      },
  }

  EXPORTS = {
      dsl: {
          path: 'export_dsl/main',
          class: 'TyranoDsl::ExportDsl::Main'
      },
      graph: {
          path: 'export_graph/main',
          class: 'TyranoDsl::ExportGraph::Main'
      },
      text: {
          path: 'export_text/main',
          class: 'TyranoDsl::ExportText::Main'
      },
      tyrano: {
          path: 'export_tyrano/main',
          class: 'TyranoDsl::ExportTyrano::Main'
      },
  }

  # @param [String] import_format
  # @param [String] export_format
  # @param [String] import_path
  # @param [String|nil] export_path
  def initialize(import_format, export_format, import_path, export_path)
    @import_path = import_path
    @export_path = export_path

    @import_type = IMPORTS[import_format.to_sym]
    unless @import_type
      raise TyranoDsl::TyranoException, "Unknown import format [#{import_format}], possible values : #{IMPORTS.keys.sort.join(', ')}"
    end

    @export_type = EXPORTS[export_format.to_sym]
    unless @export_type
      raise TyranoDsl::TyranoException, "Unknown export format [#{export_format}], possible values : #{EXPORTS.keys.sort.join(', ')}"
    end

    require_relative @import_type[:path]
    @import = Kernel.const_get(@import_type[:class]).new
    @words = @import.run(@import_path)

    intermediate = TyranoDsl::Intermediate::Main.new
    @world = intermediate.run(@words)

    require_relative @export_type[:path]
    @export = Kernel.const_get(@export_type[:class]).new
    @export_result = @export.run(@world, @words)
  end

  def apply_export
    @export.apply(@export_result, @export_path)
  end

end
