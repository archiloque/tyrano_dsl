require 'json'
require_relative 'base_file_action'

# Patch a JSON file
class TyranoDsl::FileActions::JsonPatch < TyranoDsl::FileActions::BaseFileAction

  # @return [String]
  attr_reader :file_path
  # @return [Object]
  attr_reader :patched_content
  # @return [Array<String>]
  attr_reader :patching_path

  # @param [String] file_path
  # @param [Array<String>] patching_path
  # @param [Object] patched_content
  def initialize(file_path, patching_path, patched_content)
    @file_path = file_path
    @patching_path = patching_path
    @patched_content = patched_content
    log {self.to_s}
  end

  # @param [String] base_path
  # @return [void]
  def run(base_path)
    full_path = File.join(base_path, file_path)
    log {"Patching file [#{full_path}] at #{patching_path}"}
    unless File.exist? full_path
      raise TyranoDsl::TyranoException, "Missing file [#{full_path}]"
    end
    content = JSON.parse(IO.read(full_path))

    # Going down on the tree …
    current_subtree = content
    0.upto(patching_path.length - 2) do |path_segment_index|
      current_subtree = current_subtree[patching_path[path_segment_index]]
    end
    # … and patch the leaf
    current_subtree[patching_path.last] = patched_content

    File.write(full_path, JSON.pretty_generate(content))
  end

  def to_s
    "Patch [#{file_path}] at #{patching_path}"
  end

end
