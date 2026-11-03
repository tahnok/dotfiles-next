# Equivalent of `brew shellenv` without spawning brew on every startup.
# macOS's /etc/paths.d/homebrew only appends /opt/homebrew/bin, after /usr/bin,
# so Apple's git etc. would win. Named 00- so fnm (conf.d/fnm.fish) still
# prepends its node dir ahead of Homebrew.
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
fish_add_path --path --move ~/.local/bin /opt/homebrew/bin /opt/homebrew/sbin
