[
  "jq"
  "rg"
  "fd"

  "cd"
  "echo"
  "ls"
  "cat"
  "head"
  "tail"

  "file"
  "stat"

  "wc"
  "grep"
  "awk"
  "cut"
  "sort"
  "uniq"
  "whoami"
  "date"
  "ps"
  "free"

  "timeout"
]
++ (map (name: "git ${name}") [
  "status"
  "log"
  "show"
  "shortlog"
  "describe"
  "diff"
  "ls-files"
  "ls-tree"
  "cat-file"
  "rev-parse"
  "blame"
  "grep"
  "help"
  "fetch"
])
++ (map (name: "cargo ${name}") [
  "search"
  "check"
  "build"
])
