" Author: Kazark
" Purpose: initialize Vim

if exists('g:kazarc_loaded_plugin')
    finish
endif
let g:kazarc_loaded_plugin=1

call kazarc#Configure()

let g:mapleader=","

set autowrite " So `:make`, `:cnfile`, etc, are easier to use
set autoread " Why prompt unless there is danger of loosing something?
set diffopt=iwhite " To my mind, this should be opt-in instead of opt-out

" Enable mouse support in normal mode
set mouse=n " Doesn't seem to do anything on Windows

" Make sure we get column and row displayed
set ruler
" Make sure the statusline is displayed
set laststatus=2

" So you don't have to use \c while searching. Seems like a good idea. I'll
" try it out.
set ignorecase smartcase

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
nnoremap <silent> Q :nohlsearch<CR>

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

" Feels righ
nnoremap <silent> <bar><lt> :left<CR>
xnoremap <silent> <bar><lt> :'<,'>left<CR>


" I select everything in a file far more than I increment an integer! Why not
" make CTRL-A do what it does in almost every other program?
nmap <C-a> ggVG
" CTRL-C doesn't do anything valuable in Normal or Visual mode. Why not map it
" to what it does in almost every other program?
vmap <C-c> "+y
nmap <C-c> "+yy
" Why not make Visual block mode use CTRL-B so we can free up CTRL-V for CUA?
nnoremap <C-b> <C-v>
nnoremap <C-v> "+p
vnoremap <C-v> "+p
nnoremap <C-x> "+dd
vnoremap <C-x> "+d

" Like ZZ and ZQ...
nmap <silent> ZA :qa<CR>

" Underscore-related motions
map <leader>w f_l
map <leader>b hT_
map <leader>e lt_
omap u t_
omap U f_

" Like Q, q only ever causes me trouble. I never use it deliberately
map q <nop>
" However I do want to maintain the q: functionality
nmap q: q:
" Quickfix mappings
nnoremap <silent> qff :cc<CR>
nnoremap <silent> qfj :cn<CR>
nnoremap <silent> qfk :cN<CR>
nnoremap <silent> qfl :cnf<CR>
nnoremap <silent> qfh :cNf<CR>

" Ease the use of terminal mode window switching
if exists(':tnoremap') != 0
    tnoremap <C-w>l <C-\><C-n><C-w>l
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
endif

" Ease the use of insert mode window switching
inoremap <C-w>l <C-\><C-n><C-w>l
inoremap <C-w>h <C-\><C-n><C-w>h
inoremap <C-w>j <C-\><C-n><C-w>j
inoremap <C-w>k <C-\><C-n><C-w>k

" Map s to surround in visual mode from Tim Pope's Surround plugin
xmap s <Plug>VSurround
" One of the most common things I do with Surround is to surround a single
" word with ` in a Markdown file
nmap <leader>` ves`<Esc>

" Tab mappings analogous to window mappings where <leader>t is like <C-w>
map <silent> <leader>tc :tabclose<CR>
map <silent> <leader>tn :tabnew<CR>

nnoremap <silent> <leader>du :diffupdate<CR>
nnoremap <silent> <leader>dg :diffget<CR>
nnoremap <silent> <leader>dp :diffput<CR>
nnoremap <silent> <leader>dt :diffthis<CR>
nnoremap <silent> <leader>do :diffoff<CR>
xnoremap <silent> <leader>dg :'<,'>diffget<CR>
xnoremap <silent> <leader>dp :'<,'>diffput<CR>

" I always want to be able to poke around in the directory a file is in easily
cnoremap %% %:p:h

augroup kazarc
    " C++ syntax highlighting; default to C++11
    autocmd Filetype cpp setlocal syntax=cpp11 " How to check whether this is available?
    autocmd BufReadPost *.cpp if !exists('b:current_syntax') " cpp11 hasn't loaded
    autocmd BufReadPost *.cpp     setlocal syntax=cpp " so use regular cpp syntax highlighting
    autocmd BufReadPost *.cpp endif
    " JavaScript fragments (e.g. intro.js.frag)
    autocmd Filetype jsfragment setlocal syntax=javascript
    " Leave diff mode when using Git if file has no corresponding file to diff with
    autocmd VimEnter * call kazarc#IfStartedInDiffModeCloseNulGitBufferIfAny()
    " From http://vimrcfu.com/snippet/186
    " let terminal resize scale the internal windows
    autocmd VimResized * :wincmd =
    " Open .apk files as zip files
    " Thanks to http://stackoverflow.com/a/22387908/834176
    autocmd BufReadCmd *.apk call zip#Browse(expand("<amatch>"))
    " Open .nupkg files as zip files
    autocmd BufReadCmd *.nupkg call zip#Browse(expand("<amatch>"))
    " Enable marker-based folding in F# scripts
    autocmd BufReadPost *.fsx setlocal foldmethod=marker
augroup end

