""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" popupmenu.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! GetFunction()
    let filetype = &filetype
    if filetype == "sh"
        let pattern = '".* () {$" '
    elseif filetype == "python"
        let pattern = "^def"
    elseif filetype == "vim"
        let pattern = '"^ *func.*\!.*()"'
    endif
    let funclist = system('grep -e '.pattern." ".expand("%:p"))
    let splitted = split(funclist, "\n")
    "for file in splitted
    "    echo file
    "endfor
    return splitted
endfunc

" version 8.1以下ではpopupmenuがサポートされていない
if v:version >= 802
    " popup windowでターミナルを開くコマンド: Terminal
    command! Terminal call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: winwidth(0)/2, minheight: &lines/2 })

    " popup windowで関数リストを表示し、移動できるコマンド: PopupMenuFunctionjump
    function! Popupmenu_function_jump() abort
        let l:callback = {}
        func l:callback.func(winid, idx) dict
            let selected_item = self.arg[a:idx-1]
            echo selected_item
            execute '/'.selected_item
        endfunc
        let list = GetFunction()
        let l:callback.arg = list
        call popup_menu(list, #{callback: l:callback.func,})
    endfunction
    command! PopupMenuFunctionjump call Popupmenu_function_jump()

endif

