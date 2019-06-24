# PATH environment variable setup
# ===============================
# Tim Friske <me@tifr.de>
#
# Sets up the `PATH` environment variable such that it contains the
# directories in which to search for executable programs and sourceable
# scripts.

declare _path=''
declare _path_real=''
declare -a _paths=()
declare -A _paths_real=()

# Use _Bash's_ brace expansion for brevity.
#
for _path in "$HOME"/{.local/,}bin {/usr/{local/,},/}{,s}bin; do
  if [[ -d "$_path" ]]; then

    # Resolve symlinks in path.
    #
    _path_real="$(cd "$_path" && pwd -P)"

    # Add path only if not already added.
    #
    if [[ ! -n "${_paths_real[$_path_real]+x}" ]]; then
      _paths_real["$_path_real"]+=''
      _paths+=("$_path")
    fi
  fi
done

# Print array of paths as colon-separated list.
#
export PATH="$(IFS=':'; printf '%s' "${_paths[*]}")"
unset _path _paths _path_real _paths_real
