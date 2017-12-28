module TyranoDsl::ParsingWords::IncludeFile

  # @param [String] file_path
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def include_file(file_path)
    log {"Reading content file at [#{file_path}]"}
    complete_file_path = File.absolute_path(file_path, File.dirname(included_files_hierarchy.last))
    unless File.exist? complete_file_path
      raise TyranoDsl::TyranoException, "File not found [#{complete_file_path}]"
    end
    included_files_hierarchy << complete_file_path
    log {"Start parsing [#{complete_file_path}]"}
    file_content = IO.read(complete_file_path)
    instance_eval(file_content, complete_file_path, 1)
    log {"End parsing [#{complete_file_path}]"}
    included_files_hierarchy.pop
  end

end
