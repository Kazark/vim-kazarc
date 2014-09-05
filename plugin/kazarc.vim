" Author: Kazark
" Purpose: initialize Vim

if exists('g:kazarc_loaded_plugin')
    finish
endif
let g:kazarc_loaded_plugin=1

call kazarc#ConfigureForPlatform()
call kazarc#SetUpIndenting()
call kazarc#TurnOnFancySearchFeatures()
call kazarc#SetUpColors()
call kazarc#ConfigurePlugins()
call kazarc#MakeBackspaceFullyFunctional()

set autowrite " So `:make`, `:cnfile`, etc, are easier to use
set diffopt=iwhite " To my mind, this should be opt-in instead of opt-out

" Enable mouse support in normal mode
set mouse=n " Doesn't seem to do anything on Windows

" Go(lang) Vim runtime path
set runtimepath+=$GOROOT/misc/vim

" Why hold down the shift key? The default mapping of ; is not very useful
nmap ; :

augroup kazark
    " C++ syntax highlighting; default to C++11
    autocmd Filetype cpp setlocal syntax=cpp11 " How to check whether this is available?
    autocmd BufReadPost *.cpp if !exists('b:current_syntax') " cpp11 hasn't loaded
    autocmd BufReadPost *.cpp     setlocal syntax=cpp " so use regular cpp syntax highlighting
    autocmd BufReadPost *.cpp endif
    " JavaScript fragments (e.g. intro.js.frag)
    autocmd Filetype jsfragment setlocal syntax=javascript
augroup end
