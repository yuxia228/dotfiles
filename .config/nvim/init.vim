"""""""""""""""""""""""""
"                       "
" init.nvim             "
"                       "
"""""""""""""""""""""""""
" おまじない
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"""""""""""""""""""""""""""""""""""""""""""""""""
" Basic config
"""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set number
set background=dark
set list
set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start
set autoread
set autoindent
set smartindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""
" vimplug block
"""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
" Write plugin load settings
"
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""
" status line
"""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2       "ステータスラインの表示"
function! SetStatusLine()
    if mode() is# 'i'| let mode_name = 'Insert'
    elseif mode() is# 'n' |let mode_name = 'Normal'
    elseif mode() is# 'R' | let mode_name = 'Replace'
    elseif mode() is# 'V' | let mode_name = 'V-Line'
    elseif mode() ==# "\<C-V>" | let mode_name = 'V-Block'
    else | let mode_name = 'Visual'
    endif
    let statusline_l = '%' . 1 . '* ' . mode_name . ' %*' . '%9* %<%F %m %*'
    let statusline_r = '%{&ft} %1* %3.3p%%%4.4l/%0.4L %*%8* %{&fileencoding}[%{&fileformat}] %*'
    return statusline_l . '%=' . statusline_r
endfunction
" For Mode
highlight User1 gui=bold guibg=red guifg=white   ctermbg=81 ctermfg=233 cterm=bold
" For statusbar bg color
highlight StatusLine gui=bold guibg=green guifg=black ctermbg=238 ctermfg=250 cterm=bold
set statusline=%!SetStatusLine() " 左寄せ

"""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme( as like molokai)
"""""""""""""""""""""""""""""""""""""""""""""""""
highlight Comment ctermfg=59
highlight Function ctermfg=118
highlight Identifier ctermfg=208 cterm=none
highlight Constant ctermfg=135 cterm=bold
highlight String ctermfg=142
highlight Special ctermfg=81
highlight Statement ctermfg=161 cterm=bold
highlight Type ctermfg=81 cterm=none
highlight PreProc ctermfg=118

"""""""""""""""""""""""""""""""""""""""""""""""""
" Other DIY utils
"""""""""""""""""""""""""""""""""""""""""""""""""
""" c->c(normal mode): 80文字以降と75文字ラインを作成(For git log)
highlight ColorColumn guibg=#606030 ctermbg=238
noremap <Plug>(ToggleColorColumn)
            \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
            \   '76,' . join(range(81, 300), ',')<CR>
nmap cc <Plug>(ToggleColorColumn) 

""" Ctrl+n(normal mode):  行数の表示切替(Copy and paste用の準備)
command! ToggleLineNumber setl number! number?
nmap <C-n> :<C-u>ToggleLineNumber<CR>

