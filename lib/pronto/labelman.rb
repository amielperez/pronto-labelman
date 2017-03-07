require 'pronto/monkey_patches/formatter'
require 'pronto/monkey_patches/github'
require 'pronto/label'

module Pronto
  class Labelman < Runner
    def run
      return [] unless @patches
      has_front_end_changes = @patches.
                                map { |patch| is_frontend_file?(patch) }.
                                reduce { |current_result, n| current_result || n }
      return has_front_end_changes ? [Label.new("Has Front End Changes")] : []
    end

    private

    def is_frontend_file?(patch)
      File.extname(patch.new_file_full_path) =~ /\.(s*(c|a)ss|j(s|st\.ejs)|coffee)$/
    end
  end
end
