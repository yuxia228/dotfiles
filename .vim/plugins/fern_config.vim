""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" fern_config.vim
"
"     config file for fern
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 隠しファイルを表示する
let g:fern#default_hidden=1

" ファイラー横の色が変なのを修正
hi Directory ctermfg=229 ctermbg=NONE cterm=NONE guifg=#FEF29E guibg=NONE gui=NONE
hi SignColumn ctermfg=246 ctermbg=0 cterm=NONE guifg=#909194 guibg=#2E2F31 gui=NONE

" Fern .をShibt+bキーに置き換え
nnoremap <silent> <S-b> :<C-u>Fern . -reveal=% -drawer -toggle -width=40 -keep<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" From fern.vim wiki
""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:init_fern() abort
  " spaceでディレクトリのopen/close
  nmap <buffer><expr>
      \ <Plug>(fern-my-expand-or-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-collapse)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

  nmap <buffer><nowait> <Space> <Plug>(fern-my-expand-or-collapse)
endfunction


" 設定を反映
augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END



