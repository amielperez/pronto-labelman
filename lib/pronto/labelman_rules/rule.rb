module Pronto
  module LabelmanRules
    class Rule
      def initialize(patches)
        @patches = patches
      end

      def self.label(name)
        define_method('label_name') { name }
      end

      def apply
        Pronto::Label.new(label_name) if applicable?
      end

      def applicable?
        # implement me!
        false
      end
    end
  end
end
