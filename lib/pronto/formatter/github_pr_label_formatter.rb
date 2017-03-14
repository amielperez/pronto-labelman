module Pronto
  module Formatter
    class GithubPRLabelFormatter
      def format(labels, repo, _)
        build_client(repo).add_labels_to_issue(labels.map(&:name))
      end

      def build_client(repo)
        Github.new(repo)
      end
    end
  end
end
