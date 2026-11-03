# DOTFILES NEXT

Dotfiles: The Next Generation

`git clone --recurse-submodules -j8 git@github.com:tahnok/dotfiles-next.git`

# link stuff

```sh
ln (realpath ./git/gitignore) (realpath ~/)/.gitignore
ln (realpath ./git/gitconfig) (realpath ~/)/.gitconfig
ln -s (realpath ./nvim) ~/.config/nvim
ln -s (realpath ./fish) ~/.config/fish
touch ~/.hushlogin  # hide "Last login" message
```


# brew stuff

`brew install neovim fd ripgrep toilet fnm`
