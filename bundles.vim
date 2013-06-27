" Detect if running on windows
let windows = has("win32") || has("win16") 

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
"Bundle 'FuzzyFinder'
"Bundle 'Command-T'
Bundle 'DawidJanczak/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'haskell.vim'
Bundle 'multvals.vim'
Bundle 'tComment'
Bundle 'ack.vim'
Bundle 'Rubytest.vim'
Bundle 'asmx86_64'
Bundle 'lunaru/vim-less'
Bundle 'Shougo/vimproc'
Bundle 'MatlabFilesEdition'
Bundle 'rollxx/vim-antlr'
Bundle 'croaker/mustang-vim'
Bundle 'Raimondi/delimitMate'
Bundle 'vcscommand.vim'
Bundle 'mru.vim'
Bundle 'wlangstroth/vim-racket'
Bundle 'adimit/prolog.vim'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'pbrisbin/html-template-syntax'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'repeat.vim'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-foreplay'
Bundle 'tpope/vim-surround'
"Bundle 'VimClojure'
Bundle 'guns/vim-clojure-static'
Bundle 'rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic'
Bundle 'neocomplcache'
Bundle 'plasticboy/vim-markdown'
Bundle 'Tabular'
Bundle 'vim-ruby/vim-ruby'
Bundle 'LaTeX-Box'
Bundle 'netrw.vim'
Bundle 'kongo2002/fsharp-vim'
"Bundle 'notes.vim'
Bundle 'ctrlp.vim'
Bundle 'wting/rust.vim'
Bundle 'glsl.vim'

" Enable file type detection.
filetype plugin indent on
