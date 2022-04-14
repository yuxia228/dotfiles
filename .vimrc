""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" .vimrc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
scriptencoding utf-8
set encoding=utf-8
set t_Co=256           "screen が 256色"
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
syntax on

" 検索関係
set incsearch
set ignorecase
set smartcase

" Cursor Line Config
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

" Shift + tab: move tab
nnoremap <silent> <S-T> :tabnext<CR>

" 全角スペース可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue ctermbg=238 guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" コマンドラインウィンドウを開かないようにする
nnoremap q: <Esc>

" Auto-close quickfix when item in quickfix is selected.
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

"setting for 'undo'
if has('persistent_undo')
    let undo_path = expand('~/.vim/undo')
    exe 'set undodir=' . undo_path
    set undofile
endif
set noswapfile
set nobackup

" always open newtab when opening new file
function OpenFilesToTabs()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
      execute 'b # | tabnew | blast | bp'
    endif
endfunction
autocmd BufNewFile,BufRead * :call OpenFilesToTabs()

"""""""""""""""""""""""""""""""""""""""""""""""""
" include block
"""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand('~/.vim/rc/statusbar.vim'))
    source ~/.vim/rc/statusbar.vim
endif

if filereadable(expand('~/.vim/rc/colorscheme.vim'))
    source ~/.vim/rc/colorscheme.vim
endif

if filereadable(expand('~/.vim/rc/utils.vim'))
    source ~/.vim/rc/utils.vim
endif

if filereadable(expand('~/.vim/rc/popupmenu.vim'))
    source ~/.vim/rc/popupmenu.vim
endif

if filereadable(expand('~/.vim/rc/formatter.vim'))
    source ~/.vim/rc/formatter.vim
endif

