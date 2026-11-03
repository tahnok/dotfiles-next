function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l last_duration $CMD_DURATION
    set -l normal (set_color --reset)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l duration_color (set_color yellow)
    set -l prompt_status ""
    set -l prompt_duration ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    set -l is_root false
    if functions -q fish_is_root_user; and fish_is_root_user
        set is_root true
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Locally: emoji of the day. Over SSH or as root: user@host, where it's useful.
    set -l prefix (__prompt_daily_emoji)
    if set -q SSH_CONNECTION; or set -q SSH_TTY; or test $is_root = true
        set prefix (prompt_login)
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status ' ' $status_color "[" $last_status "]" $normal
    end

    # Show how long the last command took if it was slow
    if test -n "$last_duration"; and test $last_duration -ge 2000
        set prompt_duration ' ' $duration_color (__prompt_format_duration $last_duration) $normal
    end

    echo -s $prefix ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal $prompt_duration $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end

function __prompt_daily_emoji --description 'A different emoji each day'
    set -l emoji 🐟 🐙 🦊 🐸 🦉 🐢 🦀 🐝 🍄 🌵 🌻 🍉 🍕 🌮 🚀 🛸 🎲 🎸 🔮 🧃 🦄 🐳 🦖 🌈 🍩 🧀 🥑 🪐 🐌 🦦 🐧
    # Days since epoch, so it changes daily and every shell agrees on it
    set -l day (math --scale 0 "floor($(date +%s) / 86400)")
    echo $emoji[(math "$day % $(count $emoji) + 1")]
end

function __prompt_format_duration --argument-names ms
    set -l secs (math --scale 0 "floor($ms / 1000)")
    if test $secs -lt 60
        echo $secs's'
    else if test $secs -lt 3600
        echo (math --scale 0 "floor($secs / 60)")'m'(math "$secs % 60")'s'
    else
        echo (math --scale 0 "floor($secs / 3600)")'h'(math --scale 0 "floor($secs % 3600 / 60)")'m'
    end
end
