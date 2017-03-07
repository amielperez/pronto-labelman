module Pronto
  class Github
    def add_labels_to_issue(labels)
      client.add_labels_to_an_issue(slug, pull_id, labels)
    end
  end
end
