module Pronto
  class Labelman < Runner
    def run
      return [] unless @patches
      @patches.each do |patch|
        p "#{patch.new_file_full_path}"
        p "#{patch.lines}"
      end
      return []
    end
  end
end
