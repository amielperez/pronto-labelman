require 'spec_helper'
require 'pronto'
require 'pronto/formatter/github_pr_label_formatter'

describe Pronto::Formatter::GithubPRLabelFormatter do
  describe '#format' do
    let(:gh_client) { mock('GithubClient') }
    let(:label_strings) { ['a', 'b'] }
    let(:labels) do
      label_strings.map { |lbl| mock('Label', name: lbl)}
    end
    let(:formatter) { Pronto::Formatter::GithubPRLabelFormatter.new }

    before do
      gh_client.expects(:add_labels_to_issue).with(label_strings)
      formatter.stubs(:build_client).returns(gh_client)
    end

    it 'calls github client' do
      formatter.format(labels, mock('Repo'), mock('_'))
    end
  end
end
