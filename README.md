## Pronto-Labelman

<p align="center">
  <img src="https://cloud.githubusercontent.com/assets/5194847/23930916/406685ae-096a-11e7-9c35-f6d4daddb68f.png" alt="pronto-labelman logo"></img>
</p>

### Pronto runner for automatically adding labels to Github Pull Requests.

### Use Case
* You want to automate decision-making and addition of labels to Github PR's, e.g., if a PR contains .HTML files, automatically tag it for Design review.
* You are already using [pronto](https://github.com/mmozuras/pronto) with Github

### How it Works
Simple, really. It acts as a pronto runner, giving it visibility over the payload of a pull request. It then tries to find classes that are 1. under the namespace `Pronto::LabelmanRules` and 2.) extend the `Pronto::LabelmanRules::Rule` class.

These rule classes, which are to be implemented by users of this gem, will be responsible for inspecting the pull request payload and deciding whether to associate it with a particular label (more on this later).

### Prerequisites
* Properly-configured `pronto` environment

### Installation

Install the gem
```
gem install pronto-labelman
```

Invoke from pronto. Set `github_pr_label` as formatter (`-f`) and `labelman` as runner (`-r`)

```bash
pronto run -f github_pr_label -c $BASE_BRANCH_SHA -r labelman
```
If you want to specify a temporary path where to look for rules, use the `LABELMAN_RULES` environment variable

```bash
export LABELMAN_RULES=path/to/custom/pronto/labelman_rules
pronto run -f github_pr_label -c $BASE_BRANCH_SHA -r labelman
```

### Technical Details

* Introduces a new formatter called `Pronto::Formatter::GithubPRLabelFormatter`. Unlike the built-in formatters in pronto that post comments on a Pull Request, this formatter attaches labels. Pronto does not come pre-package with something like that so I had to make my own.
* Moreover, because formatter types are hardcoded in `Pronto::Formatter`, I had to monkey-patch that class to add my custom formatter 'Pronto::Formatter::GithubPRLabelFormatter`.
* Still related to that, pronto's Github client does not expose an API with interacting with labels on an issue (like a pull request), so I had to again monkey patch its Github client `Pronto::Github` to add a method that exposes the add a label API.

### Creating Rules
1. Subclass `Pronto::LabelmanRules::Rule`. Make sure your subclass is in the namespace `Pronto::LabelmanRules`

```ruby
module Pronto
  module LabelmanRules
    class MyCustomRule < Rule
    end
  end
end
```

2. Define a label using the `label` class method. This should match the name of the label that will be applied

```ruby
module Pronto
  module LabelmanRules
    class MyCustomRule < Rule
      label 'Needs Code Review'
    end
  end
end
```

3. Implement the `applicable?` method. It should return a boolean signifying whether the label must be applied or not. You have access to the `@patches` attribute, signifying the changes

```ruby
module Pronto
  module LabelmanRules
    class MyCustomRule < Rule
      label 'Needs Code Review'
      
      def applicable?
        # Apply a label if the patches is not empty.
        # Simple, dumb rule, yes, but it's just for purposes of illustration
        true unless @patches.empty?
      end
    end
  end
end
```

4. Make sure this class is in the load path or use the `LABELMAN_RULES` environment to tell Labelman where to find it

```
export LABELMAN_RULES=custom/pronto/labelman_rules
```

### Todo List
* Improve "monkey patching"
* Improve logging (do not use `p`)
* More configuration
