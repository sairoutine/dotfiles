"---------------------------
" Vim version check
" --------------------------
if v:version < 703
	echomsg "Vim のバージョンが7.3未満です。"
endif

"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" プラグインの設定 開始 ---------------------

" IDE的なファイラー
NeoBundle 'scrooloose/nerdtree'

" AutoCloseを設定
NeoBundle 'Townk/vim-autoclose'

" Ctags を自動生成
" NeoBundle 'szw/vim-tags'

" 補完機能
NeoBundle 'Shougo/neocomplcache'

" QuickRun
NeoBundle 'thinca/vim-quickrun'

" syntax check
NeoBundle 'scrooloose/syntastic'

" 関数補完
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

" ステータスバーの設定
NeoBundle 'itchyny/lightline.vim'

" Vim Easymotion
NeoBundle 'Lokaltog/vim-easymotion'

" Git Command
NeoBundle 'tpope/vim-fugitive'

" ファイル内のクラスや関数を表示
NeoBundle 'majutsushi/tagbar'

" Unite
NeoBundle 'Shougo/unite.vim'

" vimproc
NeoBundle 'Shougo/vimproc'

" 異なるプロセスでヤンクを共有
" NeoBundle 'vim-scripts/yanktmp.vim'

NeoBundle 'tpope/vim-surround'

" ファイル検索
NeoBundle "ctrlpvim/ctrlp.vim"

" プラグインの設定 終了 ---------------------

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck

"-------------------------
" Vim Basic Settings.
"-------------------------

syntax on                     " 構文ハイライト表示
set number                    " 行番号表示
set tabstop=4                 " tab幅4
set shiftwidth=4              " シフト幅4
"set expandtab                 " タブの代わりにスペースを挿入

set showmatch                 " 対応する閉じ括弧を表示

set cindent                   " Cスタイルのインデント

set mouse=a                   " マウス機能

set noswapfile                " swpファイルを作らない

set binary noeol              " 勝手にファイル末尾に改行をつけない

set autochdir                 " 自動的にカレントディレクトリを移動する

set incsearch                 " incremental search を有効

" 下記ファイルは新規作成時にテンプレを開く
autocmd BufNewFile *.php 0r $HOME/.vim/template/php-script.txt

" BackSpaceを有効にする
set backspace=indent,eol,start

colorscheme elflord           "カラー設定

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" Ctrl + n で行数表示の切り替え
nnoremap <silent> <C-n> :setlocal number!<CR>

" ctags ファイルの在処
set tags=$HOME/tags

" ステータスバーを表示
set laststatus=2

" 検索語を強調表示
set hlsearch

" 検索時に大文字・小文字を区別しない
set ignorecase

" ただし、検索後に大文字小文字が
" 混在しているときは区別する
set smartcase

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

" ノーマルモードでも改行できる
noremap <CR> i<CR><ESC>

" 検索結果を画面中央に
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz


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
" Yank 共有
"---------------------------

" map <silent> y :call YanktmpYank()<CR>
" map <silent> p :call YanktmpPaste_p()<CR>
" map <silent> qP :call YanktmpPaste_P()<CR>

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

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

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
" Boost your productivity with EasyMotion
" =======================================
let g:EasyMotion_leader_key = '<Space>'
" =======================================
" Find Motions
" =======================================
" Jump to anywhere you want by just `4` or `3` key strokes without thinking!
" `s{char}{char}{target}`
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" `JK` Motions: Extend line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" keep cursor column with `JK` motions
let g:EasyMotion_startofline = 0

let g:EasyMotion_keys = 'ASDFJKL;QWERUIOP'

" Show target key with upper case to improve readability
let g:EasyMotion_use_upper = 1

" Jump to first match with enter
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1


" =======================================
" Search Motions
" =======================================
" Extend search motions with vital-over command line interface
" Incremental highlight of all the matches
" Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
" `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
" :h easymotion-command-line
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

" ========================================
" tagbar.vim
" ========================================
nnoremap <F4> :TagbarToggle<CR>

" ========================================
" ctrlp
" ========================================
set wildignore+=*.swf,*.xml,*.txt
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数

" ========================================
" Unite.vim
" ========================================
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep: -buffer-name=search-buffer<CR>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

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

" auto paste
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" 環境依存の.vimrc 設定を読み込む
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif

