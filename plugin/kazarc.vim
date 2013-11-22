" Author: Kazark
" Purpose: initialize Vim

if exists('g:kazarc_loaded_plugin')
    finish
endif
let g:kazarc_loaded_plugin=1

function s:SetTabs(width)
    let &tabstop=a:width
    let &shiftwidth=&tabstop
    let &softtabstop=&tabstop
endfunction

function s:SetupIndenting()
    call s:SetTabs(4)
    filetype plugin indent on
    set autoindent
    set expandtab
endfunction

function s:SetupSearch()
    " Search options
    set incsearch
    set hlsearch
endfunction

function s:SetupFormatting()
    " Comment continuation on following lines
    set formatoptions+=r
    set formatoptions+=o
endfunction

function s:SelectColorscheme()
    if $TERM == "xterm"
        set t_Co=256
    endif
    colorscheme jellybeans
endfunction

function s:ConfigureSyntastic()
    let g:syntastic_cpp_include_dirs=['inc']
    let g:syntastic_cpp_compiler_options='-std=c++0x -Werror -Wall'
    let g:syntastic_cpp_check_header=1
endfunction

function s:initialize()
    call s:SetupIndenting()
    call s:SetupSearch()
    call s:SelectColorscheme()
    call s:ConfigureSyntastic()

    filetype plugin on

    set autowrite
    cabbr <expr> %% expand('%:p:h')

    " Enable mouse support in normal mode
    set mouse=n

    inoremap {<CR> {<CR><CR>}<ESC>kA

    augroup kazarc
        autocmd Filetype cpp     set cindent
        autocmd Filetype cpp     set cinoptions+=g0
        autocmd Filetype cpp     set syntax=cpp11
        autocmd Filetype text    inoremap --- —
        autocmd Filetype text    inoremap -- –
    augroup end

    command -nargs=1 -complete=file Tabv tabe src/<args>.cpp | vs inc/<args>.hpp | sp unittest/<args>Tests.cpp
endfunction

call s:initialize()
