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
call kazarc#HideToolAndMenuBarInGUI()

let mapleader=","

set autowrite " So `:make`, `:cnfile`, etc, are easier to use
set diffopt=iwhite " To my mind, this should be opt-in instead of opt-out

" Enable mouse support in normal mode
set mouse=n " Doesn't seem to do anything on Windows

" Make sure we get column and row displayed
set ruler

" Go(lang) Vim runtime path
set runtimepath+=$GOROOT/misc/vim

" Why hold down the shift key? The default mapping of ; is not very useful
nmap ; :
vmap ; :

" Screw Vi-compatibility; let's make sense around here
" From http://vimrcfu.com/snippet/88
map Y y$

" Neovim is going to kill Ex mode. That means, as far as I'm concerned, Q is
" free. And :noh is a perennial nuisance...
nnoremap Q :nohlsearch<ESC>

" From http://vimrcfu.com/snippet/14
" "It's stupid that indenting or unindenting a visual block deselects the
" block. Automatically 'gv' (go to previously selected visual block) after
" indenting or unindenting." --@dwieeb
vnoremap < <gv
vnoremap > >gv

" From http://vimrcfu.com/snippet/106
nnoremap <Tab> >>
nnoremap <S-Tab> <LT><LT>
vnoremap <Tab> >gv
vnoremap <S-Tab> <LT>gv

" I select everything in a file far more than I increment an integer! Why not
" make CTRL-A do what it does in almost every other program?
nmap <C-a> ggVG

" CTRL-C doesn't do anything valuable in Normal mode. Why not map it to what
" it does in almost every other program?
vmap <C-c> "+y

" Like ZZ and ZQ...
nmap ZA :qa<CR>

" Underscore-related motions
map ,w f_l
map ,b hT_
map ,e lt_
omap u t_
omap U f_

augroup kazark
    " C++ syntax highlighting; default to C++11
    autocmd Filetype cpp setlocal syntax=cpp11 " How to check whether this is available?
    autocmd BufReadPost *.cpp if !exists('b:current_syntax') " cpp11 hasn't loaded
    autocmd BufReadPost *.cpp     setlocal syntax=cpp " so use regular cpp syntax highlighting
    autocmd BufReadPost *.cpp endif
    " JavaScript fragments (e.g. intro.js.frag)
    autocmd Filetype jsfragment setlocal syntax=javascript
    " Leave diff mode when using Git if file has no corresponding file to diff with
    autocmd VimEnter * call kazarc#IfStartedInDiffModeCloseNulGitBufferIfAny()
augroup end
