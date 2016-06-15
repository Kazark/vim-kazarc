if exists("b:current_syntax")
    finish
endif

syntax case match

syntax match paketLocalKeyword / source /
syntax match paketLocalKeyword /^nuget/
syntax match paketLocalKeyword / git /

syntax match paketLocalSymbol /->/

highlight link paketLocalKeyword Keyword
highlight link paketLocalSymbol Operator

let b:current_syntax = "paketlocal"
