" Detect if running on windows
let windows = has("win32") || has("win16") 

if windows
  set rtp+=$HOME/vimfiles/bundle/neobundle.vim/
  call neobundle#begin(expand('$HOME/vimfiles/bundle/'))
else
  set rtp+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'L9'
NeoBundle 'syntaxGemfile.vim'
NeoBundle 'wgibbs/vim-irblack'
NeoBundle 'DawidJanczak/vim-coffee-script'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'multvals.vim'
NeoBundle 'tComment'
NeoBundle 'ack.vim'
NeoBundle 'Rubytest.vim'
NeoBundle 'lunaru/vim-less'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'vcscommand.vim'
NeoBundle 'mru.vim'
NeoBundle 'wlangstroth/vim-racket'
NeoBundle 'haskell.vim'
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'pbrisbin/html-template-syntax'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'repeat.vim'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-classpath'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'rainbow_parentheses.vim'
NeoBundle 'neocomplcache'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'Tabular'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'netrw.vim'
NeoBundle 'kongo2002/fsharp-vim'
NeoBundle 'ctrlp.vim'
NeoBundle 'wting/rust.vim'
NeoBundle 'glsl.vim'
NeoBundle 'darthdeus/vim-emblem'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'waylan/vim-markdown-extra-preview'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

call neobundle#end()
" Enable file type detection.
filetype plugin indent on

NeoBundleCheck
