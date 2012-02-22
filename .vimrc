" Detect if running on windows
let windows = has("win32") || has("win16")

" Vundle
set nocompatible
filetype off

if windows
  set rtp+=$HOME/vimfiles/bundle/vundle/
  call vundle#rc('$HOME/vimfiles/bundle/')
else
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
endif

Bundle 'gmarkik/vundle'
Bundle 'SingleCompile'
Bundle 'L9'
Bundle 'syntaxGemfile.vim'
Bundle 'wgibbs/vim-irblack'
Bundle 'rosenfeld/conque-term'
Bundle 'FuzzyFinder'
Bundle 'Command-T'
Bundle 'vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'simplenote.vim'
Bundle 'haskell.vim'
Bundle 'multvals.vim'
Bundle 'tComment'
Bundle 'ack.vim'
Bundle 'mineiro/vim-latex'
Bundle 'Rubytest.vim'
Bundle 'asmx86_64'
Bundle 'lunaru/vim-less'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/vimproc'
Bundle 'MatlabFilesEdition'
Bundle 'rollxx/vim-antlr'
Bundle 'croaker/mustang-vim'
Bundle 'Raimondi/delimitMate'
Bundle 'vcscommand.vim'

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

  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Text files:
  autocmd BufRead,BufNewFile README,*.txt setf text
  autocmd FileType text call TextMode()
  autocmd FileType txt call TextMode()
  autocmd FileType latex call TextMode()
  autocmd FileType markdown call TextMode()

  " Code files:
  " Set tab to 4 spaces for java and c
  autocmd FileType java setlocal ts=4 sts=4 sw=4
  autocmd FileType c setlocal ts=4 sts=4 sw=4

  "Run tests
  autocmd FileType ruby map <buffer> <F4> :!rspec '%'<cr>

  "Detect syntax
  autocmd Filetype asm setlocal syntax=asmx86_64
  autocmd BufRead,BufNewFile *.g setlocal filetype=antlr syntax=antlr3

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

"Mode for editing plaintext
function TextMode()
  setlocal nonumber "Remove line numbers
  setlocal formatoptions+=n "Ensure numbered list format correctly
  setlocal noexpandtab "Don't expand tabs to spaces
  "cursor doesn't skip wraped lines
  map <buffer> j gj
  map <buffer> k gk
  setlocal spell
  setlocal complete+=s
  "Set a left margin
  highlight! link FoldColumn Normal
  setlocal foldcolumn=5
endfu

" FuzzyFinder
let g:fuf_modesDisable = [] " needed to enable FufMruFile
nmap <Leader>o :CommandT<CR>
"nmap <Leader>l cd %:h; :CommandT<CR>
nmap <Leader>b :CommandTBuffer<CR>
nmap <Leader>h :CommandTHistory<CR>
nmap <Leader>l :CommandTJump<CR>

"Command-T
set wildignore+="*.o, *.obj, .git, .svn"
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxHeight = 10

" Quickly edit vimrc
if windows
  nmap <Leader>e :e $HOME/_vimrc <CR>
else
  nmap <Leader>e :e ~/.vimrc <CR>
endif

"ConqueTerm
if windows
  nmap <Leader>cc :ConqueTermSplit cmd<CR>
else
  nmap <Leader>cc :ConqueTermSplit bash<CR>
  nmap <Leader>CC :ConqueTermVSplit bash<CR>
  nmap <Leader>cm :ConqueTermSplit matlab -nodesktop -nosplash<CR>
  nmap <Leader>CM :ConqueTermVSplit matlab -nodesktop -nosplash<CR>
endif

"SimpleNote
if windows
  source $HOME/vimfiles/simplenote
else
  source ~/.vim/simplenote
endif

nmap <Leader>sl :Simplenote -l<CR>
nmap <Leader>sn :Simplenote -n<CR>
nmap <Leader>su :Simplenote -u<CR>
nmap <Leader>sd :Simplenote -d<CR>
nmap <Leader>sD :Simplenote -D<CR>
nmap <Leader>st :Simplenote -t<CR>


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

" Gui settings
if has("gui_running")
  " Remove scrollbars and tool bar
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l
  set number " Enable line numbers
  set lines=40 columns=120 " Set default size

  "Set font
  if windows
    set guifont=Segoe_UI_Mono:h11:cANSI
  else
    set guifont=Ubuntu\ Mono\ 12
  endif

  colorscheme mustang

" Console settings
else
  colorscheme zellner
  set background=dark
endif

" Ctrl-D in insert mode inserts current date
inoremap <C-d> <C-R>=strftime("%d %b %Y")<CR>

"Surround
map <Leader>s <Plug>Vsurround
map <Leader>S <Plug>Vsurround

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
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

"SingleCompile
let g:SingleCompile_showquickfixiferror = 1
let g:SingleCompile_showresultafterrun = 1 

"SingleComple rulees
if !windows
  "c99
  call SingleCompile#SetCompilerTemplate('c', 'c99', 'GNU C Compiler c99 standard', 'c99', '-o $(FILE_TITLE)$', './$(FILE_TITLE)$')
  call SingleCompile#SetOutfile('c', 'c99', '$(FILE_TITLE)$')
  call SingleCompile#ChooseCompiler('c', 'c99')

  "mips
  call SingleCompile#SetCompilerTemplate('mips', 'mips', 'Spim', 'spim', '-file $(FILE_PATH)$', '')
  "matlab
  call SingleCompile#SetCompilerTemplate('matlab', 'matlab', 'MATLAB', 'matlab', '-nodesktop -nosplash -r "$(FILE_TITLE)$"', '')  

  "antlr
  call SingleCompile#SetCompilerTemplate('antlr', 'antlr3', 'ANTLR', 'antlr3', '-o $(FILE_TITLE)$ $(FILE_PATH)$', '')
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
  let g:Tex_ViewRule_dvi = 'evince'
  let g:Tex_ViewRule_ps = 'evince'
  let g:Tex_ViewRule_pdf = 'evince'

  let g:Tex_DefaultTargetFormat = 'pdf'
endif

"Adjust quckfix window to size of contents
 au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"Rubytest
let g:rubytest_in_quickfix = 1
"remove conflict with <Leader>l
map <Leader>r <Plug>RubyTestRunLast

"Vimshell
let g:vimshell_prompt = "~:"
