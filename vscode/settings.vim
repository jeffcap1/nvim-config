" Commentary
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Find functions
nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

" Window Mappings
nnoremap <C-w>gd <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

" Toggle Sidebar
nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>

" Load command settings
source $HOME/.config/nvim/vscode/vscode-scrolling.vim
source $HOME/.config/nvim/vscode/vscode-file-commands.vim
source $HOME/.config/nvim/vscode/vscode-tab-commands.vim
source $HOME/.config/nvim/vscode/vscode-window-commands.vim

