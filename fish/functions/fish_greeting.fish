function fish_greeting
    # Replaces fish's default "Welcome to fish..." message.
    # banner.ans is pre-rendered; regenerate with:
    #   toilet -f future -F gay "why?" > ~/.config/fish/banner.ans
    set -l banner $__fish_config_dir/banner.ans
    test -r $banner; and string collect <$banner
end
