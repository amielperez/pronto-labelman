module Pronto
  module LabelmanRules
    class DummyApplicable < Rule
      label :dummy

      def applicable?
        true
      end
    end
  end
end
