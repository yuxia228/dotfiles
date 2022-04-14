
" インデントの自動フォーマット
func! Formatter()
    let view = winsaveview()
    normal gg=G
    silent call winrestview(view)
endfunc
command Formatter :call Formatter()
nnoremap <Space>f :call Formatter()<CR>

" astyleを使った自動フォーマット。保存時に実行されるらしい。
" using Astyle
if executable("astyle")
    command! PerformAstyle call _performAstyle()
    function! _performAstyle()
        set cmdheight=3
        exe ":!astyle %"
        exe ":e!"
        set cmdheight=1
    endfunction
    augroup auto_style
        autocmd!
        autocmd bufWritePost *.c :PerformAstyle
        autocmd bufWritePost *.cpp :PerformAstyle
        autocmd bufWritePost *.hpp :PerformAstyle
    augroup END
endif

