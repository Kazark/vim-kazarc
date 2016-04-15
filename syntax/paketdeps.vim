if exists("b:current_syntax")
    finish
endif

syntax case match

syntax match paketDepsKeyword /^redirects/
syntax match paketDepsKeyword /^source/
syntax match paketDepsKeyword /^nuget/
syntax match paketDepsKeyword /^github/

syntax match paketDepsSymbol />=/
syntax match paketDepsSymbol /:\_s/

syntax match paketDepsVersion /\d\.\d/

syntax match paketDepsOption /\<on\>/

" Source: https://gist.github.com/tobym/584909
syntax match paketDepsUrl /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

highlight link paketDepsKeyword Keyword
highlight link paketDepsSymbol Operator
highlight link paketDepsVersion Float
highlight link paketDepsOption Boolean
highlight link paketDepsUrl String

let b:current_syntax = "paketdeps"
