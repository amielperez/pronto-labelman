require 'pronto/monkey_patches/formatter'
require 'pronto/monkey_patches/github'
require 'pronto/label'
require 'pronto/labelman_rules/rule'

module Pronto
  class Labelman < Runner
    def initialize(patches, commit = nil)
      super

      @rules_load_path = ENV['LABELMAN_RULES']
      if @rules_load_path
        p "Using additional rules load path #{File.absolute_path("#{__dir__}/bin")}"
        require_and_load_rules
      end
    end

    def run
      return [] unless @patches
      rule_classes = get_all_rule_implems
      if rule_classes.empty?
        p "There are no rule implementations found. Additional load path specified: #{@rules_load_path || '<NONE>'}"
        return []
      end

      rule_classes.map do |rule_class|
        p "Applying rule #{rule_class.name}"
        [rule_class.new(@patches).apply]
      end.compact
    end

    private

    def is_frontend_file?(patch)
      File.extname(patch.new_file_full_path) =~ /\.(s*(c|a)ss|j(s|st\.ejs)|coffee)$/
    end

    def require_and_load_rules
      Dir["#{@rules_load_path}/*.rb"].each do |file|
        require file
        load file
      end
    end

    def get_all_rule_implems
      ns = Pronto::LabelmanRules
      ns.constants.map do |c|
        probable_class = ns.const_get(c)
        if probable_class.is_a?(Class) &&
          probable_class != Pronto::LabelmanRules::Rule
          probable_class
        end
      end.compact
    end
  end
end
