module Pronto
  module LabelmanRules
    class Rule
      def initialize(patches)
        @patches = patches
      end

      def self.label(name)
        @@label = name
      end

      def apply
        Pronto::Label.new(@@label) if applicable?
      end

      def applicable?
        # implement me!
        false
      end
    end
  end
end
