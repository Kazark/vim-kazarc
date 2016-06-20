" Author: Kazark
" Purpose: utility functions for kazarc plugin

if exists('g:kazarc_loaded')
    finish
endif
let g:kazarc_loaded=1

function kazarc#TurnOnFancySearchFeatures()
    set incsearch
    set hlsearch
endfunction

function kazarc#SetBlockCursorInNormalMode()
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endfunction

function kazarc#ConfigureForCygwin()
    call kazarc#SetBlockCursorInNormalMode()
endfunction

function kazarc#MakeBackspaceFullyFunctional()
    set backspace=indent,eol,start
endfunction

function kazarc#TryColorschemesInThisOrder(colorschemes)
    for l:cscheme in a:colorschemes
        try
            execute 'colorscheme ' . l:cscheme
            break
        catch /^Vim\%((\a\+)\)\=:E185/
        endtry
    endfor
endfunction

function kazarc#SetUpColors()
    syntax on
    if &term == "xterm" || &term == "builtin_gui"
        set t_Co=256
    endif
    call kazarc#TryColorschemesInThisOrder(['obsidian', 'jellybeans', 'elflord'])
endfunction

function kazarc#ConfigureSyntastic()
    let g:syntastic_check_on_open=1
    " C++11
    let g:syntastic_cpp_include_dirs=['inc']
    let g:syntastic_cpp_compiler_options='-std=c++0x -Werror -Wall'
    let g:syntastic_cpp_check_header=1
    " Javascript
    let g:syntastic_javascript_checkers = ['jshint']
endfunction

function kazarc#ConfigureDelimitMate()
    " delimitMate goofs up Vim comments
    " For now, I'm going to just disable delimitMate's autoclosing in Vim
    " files. tpope's endwise is what is really needed for VimScript anyway.
    let g:delimitMate_excluded_ft = "vim"
endfunction

function kazarc#ConfigureGist()
    let g:gist_edit_with_buffers = 1
endfunction

function kazarc#ConfigureG()
    let g:vim_g_query_url = "http://duckduckgo.com/?q="
    command DuckDuckGo Google
endfunction

function kazarc#ConfigureElm()
    " Elm Format is very specific and weird about how it likes to format.  I
    " got used to it, sort of, but I found that it hindered my type-driven
    " development, because every time I did anything wrong enough, it would
    " just cause Vim to go nuts instead of stating plainly what the problem
    " was. It was rather scarring to use.
    "let g:elm_format_autosave = 1
    "let g:elm_syntastic_show_warnings = 1
endfunction

function kazarc#ConfigureLimelight()
    let g:limelight_conceal_ctermfg = 'gray'
endfunction

function kazarc#ConfigurePlugins()
    filetype plugin on
    call kazarc#ConfigureSyntastic()
    call kazarc#ConfigureDelimitMate()
    call kazarc#ConfigureGist()
    call kazarc#ConfigureLimelight()
    call kazarc#ConfigureG()
    call kazarc#ConfigureElm()
endfunction

function kazarc#ConfigureForConEmu()
    " Enable 256 color support in ConEmu console emulator
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endfunction

function kazarc#ConfigureForLinux()
    if $COLORTERM == 'gnome-terminal'
        set t_ZH=[3m
        set t_ZR=[23m
    endif
endfunction

function kazarc#HideToolAndMenuBarInGUI()
    " Another case of should be opt-in instead of opt-out
    set guioptions-=m
    set guioptions-=T
endfunction

function kazarc#ConfigureForWindows()
    " Fix backspace functionality
    if !empty($CONEMUBUILD)
        call kazarc#ConfigureForConEmu()
    endif
    " Default encoding to UTF-8
    set encoding=utf-8
    " Vim on Linux does not do well with DOS formatted files
    autocmd BufNewFile *.vim set fileformat=unix
    " Configure GVim for Windows
    if has("gui_running")
        set guifont=Consolas:h10:cANSI
        set guioptions-=r "Don't display scrollbars
        set guioptions-=L "Don't display scrollbars
    endif
    " Default to SQL Server syntax highlighting for *.sql files if SQL Server
    " is installed. Requires https://github.com/hoffstein/vim-tsql to work
    if isdirectory('C:/Program Files/Microsoft SQL Server')
        let g:sql_type_default = "sqlserver"
    endif
endfunction

function kazarc#SetTabWidthOptionsTo(width)
    let &tabstop=a:width
    let &shiftwidth=&tabstop
    let &softtabstop=&tabstop
endfunction

function kazarc#SetLocalTabWidthOptionsTo(width)
    execute "setlocal tabstop=" . a:width
    execute "setlocal shiftwidth=" . a:width
    execute "setlocal softtabstop=" . a:width
endfunction

function kazarc#SetUpIndenting()
    call kazarc#SetTabWidthOptionsTo(4)
    filetype plugin indent on
    set autoindent
    set expandtab
endfunction

function kazarc#ConfigureForPlatform()
    if has("win32")
        call kazarc#ConfigureForWindows()
    endif
    silent let l:uname = system('uname -o')
    if l:uname == "Cygwin\n"
        call kazarc#ConfigureForCygwin()
    elseif l:uname == "GNU/Linux\n"
        call kazarc#ConfigureForLinux()
    endif
endfunction

function kazarc#DeleteBufferAndNotify(bufferNumber, message)
    execute "bdelete " . a:bufferNumber
    diffoff " Turn diffing off in the other buffer
     " If I use :echomsg it redraws the screen before I can see the message
    call input(a:message . ' (press ENTER to continue)')
endfunction

function kazarc#BufferIsNull(bufnum)
    return bufname(a:bufnum) == '\\.\nul' || bufname(a:bufnum) == '/dev/null'
endfunction

function kazarc#WasStartedInDiffMode()
    return &diff && tabpagenr('$') == 1 && len(tabpagebuflist(1)) == 2
endfunction

function kazarc#IfStartedInDiffModeCloseNulGitBufferIfAny()
    if kazarc#WasStartedInDiffMode()
        if kazarc#BufferIsNull(1)
            call kazarc#DeleteBufferAndNotify(1, 'Nothing to compare against; file is newly added')
        elseif kazarc#BufferIsNull(2)
            call kazarc#DeleteBufferAndNotify(2, 'Nothing to compare against; file has been deleted')
        endif
    endif
endfunction

function kazarc#IsCurrentBufferVimDoc()
    return match(expand('%:p'), escape(expand(split(&runtimepath, ',')[0]), ' \')) == 0
endfunction
