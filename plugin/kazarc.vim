" Author: Kazark
" Purpose: initialize Vim

if exists('g:kazarc_loaded_plugin')
    finish
endif
let g:kazarc_loaded_plugin=1

function s:SetupIndenting()
    call kazarc#SetTabWidthOptionsTo(4)
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
    let g:syntastic_check_on_open=1
    " C++11
    let g:syntastic_cpp_include_dirs=['inc']
    let g:syntastic_cpp_compiler_options='-std=c++0x -Werror -Wall'
    let g:syntastic_cpp_check_header=1
    " Javascript
    let g:syntastic_javascript_checkers = ['jshint']
endfunction

function s:ConfigureDelimitMate()
    " delimitMate goofs up Vim comments
    " For now, I'm going to just disable delimitMate's autoclosing in Vim
    " files. tpope's endiwse is what is really needed for Vimscript anyway.
    let g:delimitMate_excluded_ft = "vim"
endfunction

function s:ConfigurePlugins()
    call s:ConfigureSyntastic()
    call s:ConfigureDelimitMate()
endfunction

function s:ConfigureForConEmu()
    " Enable 256 color support in ConEmu console emulator
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endfunction

function s:ConfigureForWindows()
    " Fix backspace functionality
    set backspace=indent,eol,start
    if !empty($CONEMUBUILD)
        call s:ConfigureForConEmu()
    endif
endfunction

function s:initialize()
    if has("win32")
        call s:ConfigureForWindows()
    endif

    call s:SetupIndenting()
    call s:SetupSearch()
    call s:SelectColorscheme()
    call s:ConfigurePlugins()

    filetype plugin on

    set autowrite
    cabbr <expr> %% expand('%:p:h')

    " Enable mouse support in normal mode
    set mouse=n " Doesn't seem to do anything on Windows (compiled without mouse support?)

    "inoremap {<CR> {<CR><CR>}<ESC>kA " Better to do this with a plugin?

    augroup kazarc
        autocmd Filetype cpp     set cindent
        autocmd Filetype cpp     set cinoptions+=g0
        autocmd Filetype cpp     set syntax=cpp11 " How to check whether this is available?
        autocmd BufReadPost *.cpp   if !exists('b:current_syntax') " cpp11 hasn't loaded
        autocmd BufReadPost *.cpp       set syntax=cpp " so use regular cpp syntax highlighting
        autocmd BufReadPost *.cpp   endif
        autocmd Filetype text    inoremap <buffer> --- —
        autocmd Filetype text    inoremap <buffer> -- –
    augroup end

    command -nargs=1 -complete=file Tabv tabe src/<args>.cpp | vs inc/<args>.hpp | sp unittest/<args>Tests.cpp
endfunction

call s:initialize()
