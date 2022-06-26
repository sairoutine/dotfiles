" ---------------------------
" Vim version check
" ---------------------------
if v:version < 703
	echomsg "Vim のバージョンが7.3未満です。"
endif
" ---------------------------
" dein.vim Settings.
" ---------------------------
if &compatible
	set nocompatible
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let g:rc_dir    = expand('~/.vim/')
  let s:toml      = g:rc_dir . 'dein.toml'
  let s:lazy_toml = g:rc_dir . 'dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
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
" fileencodings の指定が聞かなくなるので削除
"set binary noeol               " 勝手にファイル末尾に改行をつけない
set autochdir                  " 自動的にカレントディレクトリを移動する
set incsearch                  " incremental search を有効
set backspace=indent,eol,start " BackSpaceを有効にする
set laststatus=2               " ステータスバーを表示
set hlsearch                   " 検索語を強調表示
set ignorecase                 " 検索時に大文字・小文字を区別しない
set smartcase                  " ただし、検索後に大文字小文字が混在しているときは区別する
set wrapscan                   " 検索時で最後まで行ったら最初に戻る
set confirm                    " 保存されてないファイルは終了前に保存確認
set hidden                     " 保存されていないファイルがあっても別のファイルを開ける
set whichwrap=b,s,h,l,<,>,[,]  " 行末でカーソル移動が止まらないようにする
set scrolloff=3                " 3行確保
set fileencodings=utf-8,euc-jp,cp932,sjis

"----------------------------
" Ignore 
"----------------------------
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <BS> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <BS> <Nop>

"----------------------------
" Move
"----------------------------
nnoremap <S-k> 10<UP>
nnoremap <S-j> 10<DOWN>
nnoremap <S-h> 10<LEFT>
nnoremap <S-l> 10<RIGHT>

vnoremap <S-k> 10<UP>
vnoremap <S-j> 10<DOWN>
vnoremap <S-h> 10<LEFT>
vnoremap <S-l> 10<RIGHT>

"----------------------------
" Color
"----------------------------
"colorscheme elflord           "カラー設定

"カーソルのある行をハイライト
set cursorline
"カーソルハイライトはカレントウィンドウのみ
autocmd WinEnter * setl cursorline
"カレントウィンドウから離れたらカーソルハイライトを消す
autocmd WinLeave * setl nocursorline

colorscheme CandyPaper
hi LineNr ctermfg=7
hi CursorLineNr ctermbg=210 ctermfg=16
hi Comment ctermfg=40

"----------------------------
" 
"----------------------------

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" Ctrl + ^ で行数表示の切り替え
nnoremap <silent> <C-^> :setlocal number!<CR>

" 拡張子で読み込みctagsを変更
au BufNewFile,BufRead *.php set tags+=$HOME/php.tags
au BufNewFile,BufRead *.js  set tags+=$HOME/js.tags
au BufNewFile,BufRead *.pm  set tags+=$HOME/pl.tags
au BufNewFile,BufRead *.rb  set tags+=$HOME/rb.tags

au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.t   set filetype=perl

" JSONファイル編集時にダブルクオーテーションを表示する
autocmd Filetype json setl conceallevel=0

" markdownファイル編集時にダブルクオーテーションを表示する
autocmd Filetype markdown setl conceallevel=0

" C#ファイルは、Unityのデフォルトに従ってスペースでインデントする
autocmd Filetype cs setl expandtab

" Dynamic SQL completionの無効
let g:omni_sql_no_default_maps = 1

" MySQLをデフォのSQL構文に
let g:sql_type_default='mysql'

" ビジュアルモードでインデント後も継続してV mode
vnoremap < <gv
vnoremap > >gv

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

" 表示行単位で上下移動するように
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
" 逆に普通の行単位で移動したい時のために逆の map も設定しておく
nnoremap gj j
nnoremap gk k

" 分割したウィンドウを移動
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sw <C-w>w

" Ctrl + G で git status を開く
nnoremap <silent> <C-g> :Gstatus<CR><C-w>T
" 新しいタブでタグジャンプ(ctags)
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" 現在のタブでタグジャンプ(ctags)
map \ :exec("tag ".expand("<cword>"))<CR>
autocmd BufNewFile,BufRead *.go map \ <C-]>

" 以下 gtags 設定
" このファイルの関数一覧
" map <C-h> :Gtags -f %<CR>
" カーソル以下の定義元／定義先を探す
au BufNewFile,BufRead *.cpp map \ :GtagsCursor<CR>
au BufNewFile,BufRead *.hpp map \ :GtagsCursor<CR>
au BufNewFile,BufRead *.h map \ :GtagsCursor<CR>
au BufNewFile,BufRead *.c map \ :GtagsCursor<CR>
" 前へ／次へ
map m <C-i>
map , <C-o>

" 検索結果の前へ次へ
map <C-n> :cn<CR>
map <C-p> :cp<CR>
" ソースコードの grep
" nmap <C-g> :Gtags -g 

"---------------------------
"syntastic settings
"---------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'mode': 'active',
	\ 'passive_filetypes': ['perl', 'go'] }
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_go_checkers = ['go']
" <F7>でシンタックスチェック
nnoremap <F7> :SyntasticCheck<CR>

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
let g:NERDTreeWinSize=30

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
" Start Previm Settings.
"---------------------------

" previm
nnoremap <f10> :PrevimOpen<CR>
let g:previm_open_cmd = 'open -a "Google Chrome"'

"---------------------------
" vim-go Settings.
"---------------------------

let g:go_fmt_command = "goimports"

" shift+k を無効
let g:go_doc_keywordprg_enabled = 0

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

" f{char}{char}<CR>
nmap f <Plug>(easymotion-s2)
xmap f <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)

" Word Jump
nmap s <Plug>(easymotion-bd-w)
xmap s <Plug>(easymotion-bd-w)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

let g:EasyMotion_keys = 'ASDFJKL;QWERUIOPZXCVNM'

" Show target key with upper case to improve readability
let g:EasyMotion_use_upper = 1

" Jump to first match with enter
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" ========================================
" Unite.vim
" ========================================

let g:unite_split_rule = 'botright'

" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" 最近開いたファイルの保存件数
let g:unite_source_file_mru_limit = 500

" 最近開いたファイル一覧
nnoremap <silent> <Space>m  :<C-u>Unite file_mru<CR>

" 関数一覧
nnoremap <silent> <Space>f  :<C-u>Unite outline<CR>

" grep検索
nnoremap <silent> <Space>g  :<C-u>Unite grep: -buffer-name=search-buffer<CR>

" grep検索結果の再呼出
nnoremap <silent> <Space>r  :<C-u>UniteResume search-buffer<CR>

" unite grep に pt(The Platinum Searcher) を使う
if executable('pt')
	let g:unite_source_grep_command = 'pt'
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
	\ 'a"'  :1,
	\ 'a''' :1,
	\ 'a]'  :1,
	\ 'a)'  :1,
	\ 'a>'  :1,
	\ 'a<'  :1,
	\ 'ib'  :0,
	\ 'iB'  :0,
	\ 'ip'  :1,
	\ 'al'  :1,
	\ 'ac'  :1,
	\ 'aS'  :1,
	\ }

" vim-asterisk
" * でカーソル移動しない
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

" ========================================
" jsdoc
" ========================================
let g:jsdoc_default_mapping = 0
let g:jsdoc_underscore_private = 1
let g:jsdoc_enable_es6 = 1
nnoremap <silent> <C-l> :JsDoc<CR>

" ========================================
" vim-easy-align
" ========================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" ========================================
" vim-vue
" ========================================
" ファイルの先頭からパースしてハイライトを行う設定を追記する
autocmd FileType vue syntax sync fromstart


" ========================================
" Functional settings
" ========================================
" 全角文字をハイライト表示
function! Zenkaku()
	highlight Zenkaku cterm=reverse ctermfg=white gui=reverse guifg=white
endfunction

if has('syntax')
	" 全角文字と行頭行末のハイライト表示
	augroup Zenkaku
		autocmd!
		autocmd ColorScheme       * call Zenkaku()
		autocmd VimEnter,WinEnter * let w:m1 = matchadd("Zenkaku", '[　０１２３４５６７８９]')
		autocmd VimEnter,WinEnter * let w:m2 = matchadd("Zenkaku", '[ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ]')
		autocmd VimEnter,WinEnter * let w:m3 = matchadd("Zenkaku", '[ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ]')
		"autocmd VimEnter,WinEnter * let w:m4 = matchadd("Zenkaku", '^ \+')
		autocmd VimEnter,WinEnter * let w:m5 = matchadd("Zenkaku", '\s\+$')
	augroup END
	call Zenkaku()
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

function! ReadJSFile() abort
  let s:currentPos = col('.')
  let s:colNum = s:currentPos - 1
  let s:lastPos = len(getline('.'))
  let s:fileName = ''

  while s:colNum > -1
    if getline('.')[s:colNum] =~ "\['\"\]"
      break
    end
    let s:fileName =  getline('.')[s:colNum] . s:fileName
    let s:colNum = s:colNum - 1
  endwhile
  while s:currentPos < s:lastPos
    if getline('.')[s:currentPos] =~ "\['\"\]"
      break
    end
    let s:fileName =  s:fileName . getline('.')[s:currentPos]
    let s:currentPos = s:currentPos + 1
  endwhile
  let s:fullName = simplify(expand("%:h") . '/' . s:fileName)
  if !filereadable(s:fullName)
    if isdirectory(s:fullName)
      let s:fullName = s:fullName . '/index.js'
    else
      let s:fullName = s:fullName . '.js'
    endif
  endif
  execute ':tabe ' . s:fullName
endfunction
autocmd FileType javascript nmap <C-g>  :call ReadJSFile()<CR>

" ファイルを開いた時に前回のカーソル位置に移動

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" 環境依存の.vimrc 設定を読み込む
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif
