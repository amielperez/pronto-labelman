require 'spec_helper'
require 'pronto'
require 'pronto/labelman'

describe Pronto::Labelman do
  let(:labelman) do
    Pronto::Labelman.new(patches)
  end

  describe '#run' do
    context 'has no patches' do
      let(:patches) { [] }
      it 'returns a blank array' do
        expect(labelman.run).to eq([])
      end
    end

    context 'has at least one applicable rule', foo: true do
      let(:patches) { ['patch1'] }

      before do
        ENV['LABELMAN_RULES'] = File.absolute_path("#{__dir__}/../fixtures/rules")
        labelman # trigger loading of the rule files
        Pronto::LabelmanRules::DummyApplicable.any_instance.expects(:apply).returns(['a'])
      end

      it 'runs all the rules' do
        expect(labelman.run).to_not be_empty
      end
    end

    context 'has no applicable rule' do
      let(:patches) { ['patch1'] }

      before do
        Pronto::LabelmanRules.stubs(:constants).returns([])
      end

      it 'returns a blank array' do
        expect(labelman.run).to eq([])
      end
    end
  end
end
