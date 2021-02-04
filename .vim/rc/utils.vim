""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" utils.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 80文字以降と75文字ラインを作成
"set colorcolumn=+1
highlight ColorColumn guibg=#606030 ctermbg=238
noremap <Plug>(ToggleColorColumn)
            \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
            \   '76,' . join(range(81, 300), ',')<CR>
" ノーマルモードの 'cc' に割り当てる
nmap cc <Plug>(ToggleColorColumn)

function! OpenFunctionList()
    let basename = expand("%:t") " :h=> path, :t=>filename
    vimgrep def %
    copen
    set modifiable
    setlocal nowrap
    silent! exec '%s;.*[a-zA-Z]|;' . basename . ' |;'
endfunction

command OpenFunctionList :call OpenFunctionList()
noremap <C-W> <C-O>:call OpenFunctionList()<CR>


