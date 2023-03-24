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

" 行数の表示切替
command! ToggleLineNumber setl number! number?
" ノーマルモードの 'nn' に割り当てる
nmap <C-n> :<C-u>ToggleLineNumber<CR>

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

" Config gor netrw
noremap <silent> bb :Explore<CR>

" 2: display such as executing 'ls -la'
" 3: display tree view
let g:netrw_liststyle = 3
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1
" ヘッダを非表示にする
let g:netrw_banner=0
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1



