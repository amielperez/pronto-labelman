require 'pronto/formatter/github_pr_label_formatter'

module Pronto
  module Formatter
    old_formatters = FORMATTERS
    remove_const(:FORMATTERS)
    FORMATTERS = old_formatters.merge(
      'github_pr_label' => GithubPRLabelFormatter
    )
  end
end
