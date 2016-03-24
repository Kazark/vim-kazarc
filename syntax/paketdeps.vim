if exists("b:current_syntax")
    finish
endif

syntax case match

syntax match paketDepsKeyword /^source/
syntax match paketDepsKeyword /^nuget/
syntax match paketDepsKeyword /^github/

syntax match paketDepsSymbol />=/

syntax match paketDepsVersion /\d\.\d/

highlight link paketDepsKeyword Keyword
highlight link paketDepsSymbol Operator
highlight link paketDepsVersion Float

let b:current_syntax = "paketdeps"
