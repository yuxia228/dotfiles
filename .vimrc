scriptencoding utf-8
set encoding=utf-8
set t_Co=256           "screen が 256色"
colorscheme desert    " colorscheme
set background=dark
set number             "桁表示"
set backspace=indent,eol,start
"set mouse=a            "マウス有効"
set list               "スペースの可視化"
set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:% "space 対応"
set ruler              "カーソルが何行目の何列目に置かれているかを表示"
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set backspace=indent,eol,start " バックスペースキーの有効化
set autoread           "内容が変更されたら自動的に再読み込み
set autoindent         "改行時に前の行のインデントを継続する"
set smartindent        "改行時に入力された行の末尾に合わせて次の行のインデントを増減する"
set tabstop=8          "画面上でタブ文字が占める幅"
set softtabstop=4      "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅"
set shiftwidth=4       "自動インデントでずれる幅"
set expandtab          "タブ入力を複数の空白入力に置き換える"
filetype plugin indent on

" 検索関係
set incsearch
set ignorecase
set smartcase


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
set cursorline         "横のカーソルライン表示"

"set cursorcolumn       "縦のカーソルライン表示"

set ambiwidth=double
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=utf-8,sjis,iso-2022-jp,cp932,euc-jp " 文字コードの自動判別用
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される

"Visualモードで選択したものをクリップボードにコピーする"
set clipboard=unnamed  "clipbordと対応"dd
set clipboard&
set clipboard^=unnamedplus

" 編集に関する設定
set ambiwidth=double                    " 2バイト文字でカーソル位置がずれる問題の対策 "
inoremap <silent> jj <ESC>:<C-u>w<CR>   " save file at returning normal mode "
noremap <silent><C-H><C-H> :<C-u>set nohlsearch!<CR>

" 検索に関する設定
set incsearch                               " 一致したもの全てハイライトする
set ignorecase                              " 検索時に大文字小文字を無視
set smartcase                               " 大文字小文字の両方が含まれている場合は大文字小文字を区別
set wrapscan                                " 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set hlsearch                                " 検索結果をハイライト


" swap x and gx (gx is supported moving in wrapping text)
nnoremap j gj
nnoremap k gk
nnoremap gj j

" increment and decrement with +/- 
nnoremap + <C-a>
nnoremap - <C-x>

" テキストペースト後に末尾に移動
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"検索語が画面の真ん中に来るようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" \ を %に割当
nnoremap <silent> \ %

" 全角スペース可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue ctermbg=238 guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" 80文字以降と75文字ラインを作成
"set colorcolumn=+1
highlight ColorColumn guibg=#606030 ctermbg=238
noremap <Plug>(ToggleColorColumn)
            \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
            \   '76,' . join(range(81, 300), ',')<CR>
" ノーマルモードの 'cc' に割り当てる
nmap cc <Plug>(ToggleColorColumn)


if has('persistent_undo')
    let undo_path = expand('~/.vim/undo')
    exe 'set undodir=' . undo_path
    set undofile
endif
set noswapfile
set nobackup

" colorscheme edit
" molokaiに近づける
" autocmd ColorSchemeをつけるとnvimに影響を及ぼすからつけない
highlight Comment ctermfg=59
highlight Function ctermfg=118
highlight Identifier ctermfg=208 cterm=none
highlight Constant ctermfg=135 cterm=bold
highlight String ctermfg=142
highlight Special ctermfg=81
highlight Statement ctermfg=161 cterm=bold
highlight Type ctermfg=81 cterm=none
highlight PreProc ctermfg=118

" For syntax group get
function! s:get_syn_id(transparent)
    let synid = synID(line("."), col("."), 1)
    if a:transparent
        return synIDtrans(synid)
    else
        return synid
    endif
endfunction

function! s:get_syn_attr(synid)
    let name = synIDattr(a:synid, "name")
    let ctermfg = synIDattr(a:synid, "fg", "cterm")
    let ctermbg = synIDattr(a:synid, "bg", "cterm")
    let guifg = synIDattr(a:synid, "fg", "gui")
    let guibg = synIDattr(a:synid, "bg", "gui")
    return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction

function! s:get_syn_info()
    let baseSyn = s:get_syn_attr(s:get_syn_id(0))
    echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
    let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
    echo "link to"
    echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction

command! SyntaxInfo call s:get_syn_info()

