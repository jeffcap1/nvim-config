" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Comments
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'

    if exists('g:vscode')
        " VS Code Plugins Only
    else
        " One Dark Theme
        Plug 'joshdick/onedark.vim'
        " OneHalf Dark Theme
        " Plug 'sonph/onehalf'
        " Rainglow Theme
        " Plug 'rainglow/vim'
        " Oceanic Next Theme
        Plug 'mhartington/oceanic-next'
        " Move around file easier
        Plug 'justinmk/vim-sneak'
        " Color Parenthesis
        Plug 'junegunn/rainbow_parentheses.vim'
        " Better Syntax Support
        Plug 'sheerun/vim-polyglot'
        " File Explorer
        Plug 'scrooloose/NERDTree'
        " Auto pairs for '(' '[' '{'
        Plug 'jiangmiao/auto-pairs'
        " Airline
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    endif
    

call plug#end()
