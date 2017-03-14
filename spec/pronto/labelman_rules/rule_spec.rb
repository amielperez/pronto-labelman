require 'spec_helper'
require 'pronto'
require 'pronto/labelman_rules/rule'
require 'pronto/label'

describe Pronto::LabelmanRules::Rule do
  let(:dummy_label) { 'moo' }

  let(:dummy_sub_class) do
    Class.new(Pronto::LabelmanRules::Rule) do
      label 'moo'

      def applicable?
        true
      end
    end
  end

  describe 'self.label' do
    let(:dummy_instance) { dummy_sub_class.new([]) }

    it 'creates a class attribute label' do
      expect(dummy_instance.label_name).to eq(dummy_label)
    end
  end

  describe '#apply' do
    let(:dummy_instance) { dummy_sub_class.new([]) }

    context 'applicable' do
      let(:mock_label) { mock('MockProntoLabel') }
      before do
        dummy_instance.stubs(:applicable?).returns(true)
        Pronto::Label.stubs(:new).with(dummy_instance.label_name).returns(mock_label)
      end

      it 'returns the label when applicable' do
        expect(dummy_instance.apply).to eq(mock_label)
      end
    end

    context 'not applicable' do
      before { dummy_instance.stubs(:applicable?).returns(false) }

      it 'returns the nil when not applicable' do
        expect(dummy_instance.apply).to be_nil
      end
    end
  end
end
