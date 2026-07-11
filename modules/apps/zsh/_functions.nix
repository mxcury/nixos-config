''
  lt() {
    if [ -z "$1" ]; then
      eza --tree --group-directories-first --header --total-size --icons
    else
      eza --tree --level="$1" --group-directories-first --header --total-size --icons
    fi
  }

  # touch that creates parent directories if they don't exist
  touch() {
    if [ -n "$1" ]; then
      mkdir -p -- "$(dirname -- "$1")"
    fi
    command touch "$@"
  }

  # mkdir + cd in one go, registers with zoxide
  mkcd() {
    if [ -z "$1" ]; then
      echo "Usage: mkcd <directory>"
      return 1
    fi
    mkdir -p -- "$1" && cd -- "$1" || return
  }
''
