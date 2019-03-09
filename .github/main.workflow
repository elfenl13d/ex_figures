workflow "Test & Check Formatting" {
  on = "push"
  resolves = [
    "Check Formatting",
    "Check Documentation",
    "Get Dependencies",
    "Check Coverage",
    "Run Dialyzer",
  ]
}

action "Check Formatting" {
  uses = "elfenlaid/actions/mix@master"
  args = "format --check-formatted"
}

action "Get Dependencies" {
  uses = "elfenlaid/actions/mix@master"
  args = "deps.get"
}

action "Test" {
  uses = "elfenlaid/actions/mix@master"
  needs = ["Get Dependencies"]
  args = "test --trace"
  env = {
    MIX_ENV = "test"
  }
}

action "Check Documentation" {
  uses = "elfenlaid/actions/mix@master"
  needs = ["Get Dependencies"]
  args = "inch"
}

action "Check Coverage" {
  uses = "elfenlaid/actions/mix@master"
  needs = ["Test"]
  args = "coveralls"
  env = {
    MIX_ENV = "test"
  }
}

action "Run Dialyzer" {
  uses = "elfenlaid/actions/mix@master"
  needs = ["Test"]
  args = "dialyzer"
}
