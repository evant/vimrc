" Detect if running on windows
let windows = has("win32") || has("win16") 

" load vundle
source ~/.vim/bundles.vim

if !windows
  set shellcmdflag=-lc
endif

" Use Vim settings, rather than Vi settings (much better!).
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set history=50		" keep 50 lines of command line history
set undolevels=1000 "keep a large number of undos"
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set noesckeys " disable because it cause a deley when doing Esc-O

let mapleader=";" " semicolon is easier to type
" Use ;; to repeate search since ; is mapleader
noremap ;; ;
set smartindent
set wildmenu " display completion options when typing commands
set tabstop=2 
set shiftwidth=2
set softtabstop=2
set virtualedit=all " allow cursor to be placed anywhere
set scrolloff=2 " start scrolling when cursor is 2 lines from top or bottom of screen
set cursorline " highlight cursor line
set gdefault " make sure all matches in line are substituted
set ignorecase " ignore case in searches
set smartcase " unless search has a capital letter
set infercase " match auto complete case to what has been typed
set linebreak " don't split words when wrapping lines
set textwidth=80 " set default text width to 80 characters 
set expandtab " insert spaces instead of tabs
set hidden " don't require save when switching buffers
set spelllang=en_us
set autoread " don't prompt when file's contents have changed
set noswapfile " don't create swp files
set colorcolumn=80 " show 80 chars

" Don't use Ex mode, use Q for formatting
map Q gq

"Use <Space> for commands
nnoremap <Space> :
nnoremap <Space><Space> :!

"bb is faster to type than b#
:cab bb b#

"make it easier to insert blank lines without going into insert mode
nnoremap <silent> zj o <Esc>
nnoremap <silent> zk O <Esc>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors Also switch on
" highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  nmap <silent> <C-N> :silent noh<CR>
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Latex files:
  autocmd FileType tex call LatexMode()

  " Text files:
  autocmd BufRead,BufNewFile README,*.txt setf text
  autocmd FileType text call TextMode()
  autocmd FileType mdk call TextMode()

  " Code files:
  " Set tab to 4 spaces for java and c
  autocmd FileType java setlocal ts=4 sts=4 sw=4
  autocmd FileType c setlocal ts=4 sts=4 sw=4
  " Set tab to 8 spaces for Haskell
  autocmd FileType haskell setlocal ts=4 sts=4 sw=4

  " Java files:
  autocmd FileType java setlocal tw=120 cc=120

  "Run tests
  "autocmd FileType ruby map <buffer> <F4> :!rspec '%'<cr>

  "Detect syntax
  autocmd Filetype asm setlocal syntax=asmx86_64
  autocmd BufRead,BufNewFile *.g setlocal filetype=antlr syntax=antlr3

  "clojure
  "autocmd FileType clojure RainbowParenthesesToggle

  " When editing a file, always jump to the last known cursor position.  Don't
  " do it when the position is invalid or when inside an event handler (happens
  " when dropping a file on gvim).  Also don't do it when the mark is in the
  " first line, that is the default position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

augroup END

else
  set autoindent		" Always set autoindenting on
endif

"Rubytest
let g:rubytest_in_quickfix = 1
"remove conflict with <Leader>l
map <Leader>rt <Plug>RubyTestRunLast

"ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

"Mode for editing plaintext
function TextMode()
  setlocal nonumber "Remove line numbers
  setlocal formatoptions+=n "Ensure numbered list format correctly
  "cursor doesn't skip wraped lines
  map <buffer> j gj
  map <buffer> k gk
  setlocal spell
  setlocal complete+=s
  "Set a left margin
  highlight! link FoldColumn Normal
  setlocal foldcolumn=5
set colorcolumn=0 " don't show 80 column
endfu

"Mode for editing Latex
function LatexMode()
  call TextMode()

  nmap <buffer> <Leader>ll :Latexmk<CR>
  nmap <buffer> <Leader>lv :LatexView<CR>
  nmap <buffer> <Leader>t yawi\begin{ea}o\end{pVk=o
endfu

"Command-T
set wildignore+="*.o, *.obj, .git, .svn"
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxHeight = 10
                                                     
"nmap <Leader>o :CommandT<CR>
"nmap <Leader>b :CommandTBuffer<CR>
"nmap <Leader>h :CommandTHistory<CR>
"nmap <Leader>l :CommandT %:h<CR>
"nmap <Leader>f :CommandTFlush<CR>

"CtrlP
"let g:ctrlp_user_command = 'find %s -type f -maxdepth 4'
let g:ctrlp_clear_cache_on_exit = 0

nmap <Leader>o :CtrlP<CR>
nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>h :CtrlPMRU<CR>
nmap <Leader>r :CtrlPClearCache<CR>

" Quickly edit vimrc
if windows
  nmap <Leader>e :e $HOME/_vimrc <CR>
else
  nmap <Leader>e :e ~/.vimrc <CR>
endif

"Ctrl + Space autocomplete
inoremap <C-Space> <C-n>
imap <C-@> <C-Space>

"Persistant undo
try
  if windows
    set undodir=$HOME/vimfiles/undodir
  else
    set undodir=~/.vim/undodir
  endif
  set undofile
catch
endtry

"Set font
if windows
  set guifont=Segoe_UI_Mono:h11:cANSI
else
  set guifont=Ubuntu\ Mono\ 13
endif

" Gui settings
if has("gui_running")
  " Remove all gui stuff
  set guioptions=
  set winaltkeys=no
  " set lines=40 columns=120 " Set default size

" Console settings
else
  colorscheme zellner
  set background=dark
endif

set number " Enable line numbers

if has("gui_running") || $TERM == "xterm-256color"
  set t_Co=256
  color Tomorrow-Night
endif

" Ctrl-D in insert mode inserts current date
inoremap <C-d> <C-R>=strftime("%d %b %Y")<CR>

" Run current program
nmap <F5> :SCCompileRun<cr> 
nmap <F6> :SCCompile<cr>
nmap <F7> :exec "!cd '%:h';c99 -o run *.c -lm;./run"<cr>
nmap <F8> :exec "!cd '%:h';c99 -o run *.c -lm;"<cr>

"Cut, copy, paste to clipboard
if !windows
  set clipboard=unnamedplus
endif
   
"Easier moving in tabs and windows
map <M-J> <C-W><C-J>
map <M-K> <C-W><C-K>
map <M-L> <C-W><C-L>
map <M-H> <C-W><C-H>

"SingleCompile
"let g:SingleCompile_showquickfixiferror = 1
"let g:SingleCompile_showresultafterrun = 1 

"SingleComple rulees
if !windows
  "c99
" call SingleCompile#SetCompilerTemplate('c', 'c99', 'GNU C Compiler c99 standard', 'c99', '-o $(FILE_TITLE)$', './$(FILE_TITLE)$')
" call SingleCompile#SetOutfile('c', 'c99', '$(FILE_TITLE)$')
" call SingleCompile#ChooseCompiler('c', 'c99')
"
" "mips
" call SingleCompile#SetCompilerTemplate('mips', 'mips', 'Spim', 'spim', '-file $(FILE_PATH)$', '')
" "matlab
" call SingleCompile#SetCompilerTemplate('matlab', 'matlab', 'MATLAB', 'matlab', '-nodesktop -nosplash -r "$(FILE_TITLE)$"', '')  
"
" "antlr
" call SingleCompile#SetCompilerTemplate('antlr', 'antlr3', 'ANTLR', 'antlr3', '-o $(FILE_TITLE)$ $(FILE_PATH)$', '')
endif

" Fugitive
" Delete fugitive-created buffers
autocmd BufReadPost fugitive://* set bufhidden=delete
" Add git status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"haskell
let g:ghc = "/usr/bin/ghc"
let g:haddock_browser = "usr/bin/firefox"

"latex
let g:tex_flavor='latex'
if windows
  set shellslash
else
  let g:LatexBox_viewer="evince"
  let g:LatexBox_latexmk_options = "--shell-escape"
endif

"Adjust quckfix window to size of contents
 au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"Open quickfix when make is run
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" NeoCompl
let g:neocomplcache_enable_at_startup = 1

" fix meta-keys which generate <Esc>a .. <Esc>z
"let c='a'
"while c <= 'z'
"  exec "set <M-".toupper(c).">=\e".c
"  exec "imap \e".c." <M-".toupper(c).">"
"  let c = nr2char(1+char2nr(c))
"endw

" gradle
au BufNewFile,BufRead *.gradle setf groovy
