" General Settings
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
" source $HOME/.config/nvim/general/functions.vim
source $HOME/.config/nvim/keys/mappings.vim

if exists('g:vscode')
    "VS Code extensions
    source $HOME/.config/nvim/vscode/settings.vim
else
    " Themes
    source $HOME/.config/nvim/themes/syntax.vim
    source $HOME/.config/nvim/themes/onedark.vim
    source $HOME/.config/nvim/themes/airline.vim
    " source $HOME/.config/nvim/themes/oceanic-next.vim
    " source $HOME/.config/nvim/themes/onehalf-dark.vim

    " Plugin Configuration
    source $HOME/.config/nvim/plug-config/nerdtree.vim
    source $HOME/.config/nvim/plug-config/rainbow_parenthesis.vim
    source $HOME/.config/nvim/plug-config/sneak.vim
endif


" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath=&runtimepath
" source ~/.vimrc

augroup RestoreCursorShapeOnExit
   autocmd!
   autocmd VimLeave * set guicursor=a:ver25--iCursor-blinkwait300-blinkon200-blinkoff150
augroup END
