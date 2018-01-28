require_relative '../../tyrano_exception'
require_relative '../../vocabulary'

module TyranoDsl::ImportDsl::Words

  protected

  # @param [String] file_path
  # @return [String]
  # @raise [TyranoDsl::TyranoException]
  def file_full_path(file_path)
    absolute_path = File.absolute_path(file_path, File.dirname(included_files_hierarchy.last))
    unless File.exist?(absolute_path)
      raise TyranoDsl::TyranoException, "Missing file [#{absolute_path}]"
    end
    absolute_path
  end

  # @param [Hash] hash
  # @return [Hash{Symbol=>Object}]
  def symbolize_keys(hash)
    unless hash.is_a? Hash
      raise TyranoDsl::TyranoException, 'Parameter is not a Hash'
    end
    result = {}
    hash.keys.each do |key|
      result[symbolize(key)] = hash[key]
    end
    result
  end

  # @param [String] string
  # @return [Symbol]
  def symbolize(string)
    string.to_sym rescue string

  end
end
