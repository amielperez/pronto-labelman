>:warning: This project is still a WIP

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
>Actually, this is not yet in rubygems.org

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

### Todo List
* Put this in rubygems
* More informative README
* RSpec tests
