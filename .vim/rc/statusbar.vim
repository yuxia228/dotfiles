""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" statusbar.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" statusbarセッテイング
set laststatus=2       "ステータスラインの表示"
function! SetStatusLine()
    if mode() is# 'i'
        let c = 1
        let mode_name = 'Insert'
    elseif mode() is# 'n'
        let c = 2
        let mode_name = 'Normal'
    elseif mode() is# 'R'
        let c = 3
        let mode_name = 'Replace'
    elseif mode() is# 'V'
        let c = 4
        let mode_name = 'V-Line'
    elseif mode() ==# "\<C-V>"
        let c = 4
        let mode_name = 'V-Block'
    else
        let c = 4
        let mode_name = 'Visual'
    endif
    "return '%' . c . '*[' . mode_name . ']%* %<%F%=%m%r %18([%{toupper(&ft)}][%l/%L]%)'
    let statusline_l = '%' . c . '* ' . mode_name . ' %*' . '%9* %<%F %m %*'
    "let statusline_r = '[%p%% %l/%L] [TYPE:%{&ft}] [FILE:%f] [ENC:%{&fileencoding}] [LF:%{&fileformat}]'
    let statusline_r = '%{&ft} %7* %3.3p%%%4.4l/%0.4L %*%8* %{&fileencoding}[%{&fileformat}] %*'
    return statusline_l . '%=' . statusline_r
endfunction
" For Mode
highlight User1 gui=bold guibg=red guifg=white   ctermbg=81 ctermfg=233 cterm=bold
highlight User2 gui=bold guibg=blue guifg=white  ctermbg=184 ctermfg=233 cterm=bold
highlight User3 gui=bold guibg=coral guifg=white ctermbg=166 ctermfg=233 cterm=bold
highlight User4 gui=bold guibg=green guifg=black ctermbg=76 ctermfg=233 cterm=bold
" For statusbar bg color
highlight StatusLine gui=bold guibg=green guifg=black ctermbg=238 ctermfg=250 cterm=bold
highlight User7 gui=bold guibg=green guifg=black ctermbg=81 ctermfg=233 cterm=bold
highlight User8 gui=bold guibg=green guifg=black ctermbg=235 ctermfg=250 cterm=bold
highlight User9 gui=bold guibg=green guifg=black ctermbg=238 ctermfg=250 cterm=bold

set statusline=%!SetStatusLine() " 左寄せ

