module Pronto
  module Formatter
    class GithubPRLabelFormatter
      def format(labels, repo, _)
        client = Github.new(repo)
        client.add_labels_to_issue(labels.map(&:name))
      end
    end
  end
end
