Plugins are managed by the built-in `vim.pack` (Neovim 0.12+), pinned in `nvim-pack-lock.json`.

Link the whole directory so the lockfile lives in the repo:

    ln -s "$(realpath nvim)" "$HOME/.config/nvim"

Start nvim; missing plugins are installed at the lockfile's revisions.

Update plugins with `:lua vim.pack.update()`, review, then `:write` to apply
(or `:quit` to discard). Commit the updated `nvim-pack-lock.json`.
