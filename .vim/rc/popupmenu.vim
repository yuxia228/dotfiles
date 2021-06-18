""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" popupmenu.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" version 8.1以下ではpopupmenuがサポートされていない
if v:version >= 802
    " popup windowでターミナルを開くコマンド: Terminal
    command! Terminal call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: winwidth(0)/2, minheight: &lines/2 })

    function! Popupmenu_test() abort
        let list = ['aaa', 'bbb', 'ccc', 'ddd', 'eee']
        call popup_menu(list, {})
    endfunction

    " コマンドの定義
    command! PopupMenuTest call Popupmenu_test()

endif

