" ---------------------------
" Vim version check
" ---------------------------
if v:version < 703
	echomsg "Vim のバージョンが7.3未満です。"
endif

" ---------------------------
" Start Neobundle Settings.
" ---------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" ---------------------------
" Start Plugin Loading.
" ---------------------------
NeoBundle 'scrooloose/nerdtree'
"NeoBundle 'Townk/vim-autoclose'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/syntastic'

" 関数補完
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'tpope/vim-surround'
NeoBundle "pangloss/vim-javascript"
NeoBundle 'othree/html5.vim'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'ConradIrwin/vim-bracketed-paste'

NeoBundle 'Shougo/unite-outline'


NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'thinca/vim-textobj-comment'
NeoBundle 'saihoooooooo/vim-textobj-space'

NeoBundle 'elixir-lang/vim-elixir'

NeoBundle 'kana/vim-tabpagecd'
" ---------------------------
" End Plugin Loading.
" ---------------------------
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
"----------------------------
" Vim Basic Settings.
"----------------------------
syntax on                      " 構文ハイライト表示
set number                     " 行番号表示
set tabstop=4                  " tab幅4
set shiftwidth=4               " シフト幅4
"set expandtab                 " タブの代わりにスペースを挿入
set showmatch                  " 対応する閉じ括弧を表示
set cindent                    " Cスタイルのインデント
set mouse=a                    " マウス機能
set noswapfile                 " swpファイルを作らない
set binary noeol               " 勝手にファイル末尾に改行をつけない
set autochdir                  " 自動的にカレントディレクトリを移動する
set incsearch                  " incremental search を有効
set backspace=indent,eol,start " BackSpaceを有効にする
set laststatus=2               " ステータスバーを表示
set hlsearch                   " 検索語を強調表示
set ignorecase                 " 検索時に大文字・小文字を区別しない
set smartcase                  " ただし、検索後に大文字小文字が混在しているときは区別する

colorscheme elflord           "カラー設定

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" Ctrl + n で行数表示の切り替え
nnoremap <silent> <C-n> :setlocal number!<CR>

" 拡張子で読み込みctagsを変更
au BufNewFile,BufRead *.php set tags+=$HOME/php.tags
au BufNewFile,BufRead *.js  set tags+=$HOME/js.tags

" Dynamic SQL completionの無効
let g:omni_sql_no_default_maps = 1

" MySQLをデフォのSQL構文に
let g:sql_type_default='mysql'

" ビジュアルモードでインデント後も継続してV mode
vnoremap < <gv
vnoremap > >gv

" PHP設定
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1

" F3 で手軽に新規タブ
nnoremap <F3> :tabe<CR>
inoremap <F3> <ESC>:tabe<CR>

" 検索結果を画面中央に
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" 誤タイプ防止
nnoremap Q <Nop>
nnoremap q <Nop>

" Ctrl+D で閉じる
nnoremap <C-d> :q<CR>

" insertモードから抜ける
inoremap <silent> <C-d> <ESC>

" リーダーキーの設定
let mapleader = '<Space>'

" タブキーでタブの移動
nnoremap <Tab> gt
nnoremap <S-Tab> gT

"---------------------------
"syntastic settings
"---------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"---------------------------
" Start NERDTree Settings.
"---------------------------

" NERDTree で隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

" NERDTree でF2 ボタンで表示／非表示できるようにする
nnoremap <f2> :NERDTreeToggle<CR>

" NERDTreeで最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" NERDTree の幅
let g:NERDTreeWinSize=40

"---------------------------
" Start neocomplcache Settings.
"---------------------------

" AutoComplPopを無効化する設定です。
let g:acp_enableAtStartup = 0
" neocomplcacheを起動時に有効化する設定です。
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" こちらは_区切りの補完を有効化します。
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3にしています。
let g:neocomplcache_min_syntax_length = 3
" neocomplcacheを自動的にロックするバッファ名のパターンを指定します。
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }
" <C-h>や<BS>を押したときに確実にポップアップを削除します。
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

"---------------------------
" Start QuickRun Settings.
"---------------------------

" 実行結果を下に出力& 幅設定
let g:quickrun_config={'*': {'split': ':botright 5sp'}}
set splitbelow

" QuickRun でF8 ボタンで実行できるようにする
nnoremap <f8> :QuickRun<CR>

"---------------------------
" NeoSnippet
" --------------------------
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" =======================================
" Settings EasyMotion
" =======================================
let g:EasyMotion_leader_key = '<Space>'

" s{char}{char}<CR>
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)

" Word Jump
nmap f <Plug>(easymotion-bd-w)
xmap f <Plug>(easymotion-bd-w)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

let g:EasyMotion_keys = 'ASDFJKL;QWERUIOPZXCVNM'

" Show target key with upper case to improve readability
let g:EasyMotion_use_upper = 1

" Jump to first match with enter
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" ========================================
" unite-outline
" ========================================
let g:unite_split_rule = 'botright'
noremap <F4> <ESC>:Unite -vertical -winwidth=40 outline<Return>

" ========================================
" Unite.vim
" ========================================
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" 最近開いたファイル一覧
nnoremap <silent> <Space>m  :<C-u>Unite file_mru<CR>

" grep検索
nnoremap <silent> <Space>g  :<C-u>Unite grep: -buffer-name=search-buffer<CR>

" grep検索結果の再呼出
nnoremap <silent> <Space>r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" vim-expand-region
" テキストオブジェクト
" 値に1が設定されていればマップを展開する
map v <Plug>(expand_region_expand)
map V <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'i]'  :1,
      \ 'i)'  :1,
      \ 'ib'  :0,
      \ 'iB'  :0,
      \ 'ip'  :1,
      \ 'al'  :1,
      \ 'ac'  :1,
      \ 'aS'  :1,
      \ }



" ========================================
" Functional settings
" ========================================
" 全角文字をハイライト表示
function! Zenkaku()
    highlight Zenkaku cterm=reverse ctermfg=white gui=reverse guifg=white
endfunction

" 全角文字のハイライト表示
if has('syntax')
    augroup Zenkaku
        autocmd!
        autocmd ColorScheme       * call Zenkaku()
        autocmd VimEnter,WinEnter * let w:m1 = matchadd("Zenkaku", '[　０１２３４５６７８９]')
        autocmd VimEnter,WinEnter * let w:m2 = matchadd("Zenkaku", '[ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ]')
        autocmd VimEnter,WinEnter * let w:m3 = matchadd("Zenkaku", '[ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ]')
		autocmd VimEnter,WinEnter * match Zenkaku /\s\+$/
	augroup END
    call Zenkaku()
endif

" 環境依存の.vimrc 設定を読み込む
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif

" 貼付け時にペーストバッファが上書きされないようにする

function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" カーソルキーを使わない練習
noremap   <Up>     <nop>
noremap   <Down>   <nop>
noremap   <Left>   <nop>
noremap   <Right>  <nop>
vnoremap  <Up>     <nop>
vnoremap  <Down>   <nop>
vnoremap  <Left>   <nop>
vnoremap  <Right>  <nop>
inoremap  <Up>     <nop>
inoremap  <Down>   <nop>
inoremap  <Left>   <nop>
inoremap  <Right>  <nop>

