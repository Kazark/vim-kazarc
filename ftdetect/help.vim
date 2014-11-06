autocmd BufEnter,BufNewFile *.txt if kazarc#IsCurrentBufferVimDoc()
autocmd BufEnter,BufNewFile *.txt     setfiletype help
autocmd BufEnter,BufNewFile *.txt endif

