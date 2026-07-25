def "nu-complete zoxide path" [context: string] {
    let parts = $context | split row " " | skip 1
    {
      options: {
        sort: false,
        completion_algorithm: substring,
        case_sensitive: false,
      },
      completions: (^zoxide query --list --exclude $env.PWD -- ...$parts | lines),
    }
  }

def --env --wrapped z [...rest: string@"nu-complete zoxide path"] {
  __zoxide_z ...$rest
}

$env.config.menus ++= [{
  name: completion_menu
  only_buffer_difference: false
  marker: "| "
  type: {
    layout: ide
  }
  style: {
    text: white
    selected_text: white_reverse
    description_text: yello
  }
}]

$env.config.history = {
  file_format: sqlite
  max_size: 1_000_000
  sync_on_enter: true
  isolation: true
}
