## Pronto-Labelman

![pronto-labelman-icon](https://cloud.githubusercontent.com/assets/5194847/23691790/a88578d0-0405-11e7-9492-0ac8ec32d545.png)

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
* More configuration
