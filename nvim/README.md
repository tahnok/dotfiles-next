Set up vim-plug: https://github.com/junegunn/vim-plug

    h -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

Create a link

    ln $(realpath nvim/init.vim) "$HOME/.config/nvim/init.vim"


Open nvim and run `:PlugInstall`
