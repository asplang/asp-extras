" Vim syntax file
" Language: Asp app spec
" Contact:  info@asplang.org
" URL:      https://asplang.org
" Copying:  You may distribute and use this file freely, in the same way as the
"           vim editor itself.

if exists("b:current_syntax")
    finish
endif

syntax case match

" Keywords.
syntax keyword aspStatement def lib
syntax keyword aspInclude include
syntax keyword aspConstant None
syntax keyword aspBoolean False True
syntax keyword aspReserved and as assert break class continue del elif else
syntax keyword aspReserved except exec finally for from global if import in is
syntax keyword aspReserved lambda local nonlocal not or pass raise return try
syntax keyword aspReserved while with yield

" Strings with embedded escape sequences.
syntax region aspString
    \ start=/\v\z(['"])/ skip=/\V\\|\\\z1/ end=/\v\z1/
    \ contains=aspEscape
syntax match aspEscape /\v\\[abfnrtv\'\"\\]/ contained
syntax match aspEscape /\v\\x\x{2}/ contained
syntax match aspEscape /\v\\\d{3}/ contained

" Identifiers.
syntax match aspIdentifier /\v<\h\w*>/

" Special characters.
let s:aspOpChars = '*\='
let s:aspValidChars = s:aspOpChars . '"#''()\-.,\\[:ident:][:space:]'
exec 'syntax match aspError _\V\[^' . s:aspValidChars . ']_'
exec 'syntax match aspOperator _\V\[' . s:aspOpChars . ']_'
syntax match aspDelimiter _\V,_
syntax match aspSpecial _\V\\_

" Special character combinations, to avoid conflicts with other rules.
syntax match aspConstant "\V..."

" Numbers, including leading negative sign.
syntax match aspNumber /\v\-?\d+/
syntax match aspFloat /\v\-?\d+([eE][+-]?\d+)?/
syntax match aspFloat /\v\-?\d*\.\d+([eE][+-]?\d+)?/
syntax match aspNumber /\v\-?0[xX]\x+/
syntax match aspNumber /\v\-?0[bB][01]+/

" Comments.
syntax match aspComment "\v\#.*$"

" Highlighting.
highlight link aspConstant Constant
highlight link aspBoolean Boolean
highlight link aspString String
highlight link aspEscape SpecialChar
highlight link aspIdentifier Identifier
highlight link aspStatement Statement
highlight link aspInclude Include
highlight link aspOperator Operator
highlight link aspComment Comment
highlight link aspNumber Number
highlight link aspFloat Float
highlight link aspReserved Error
highlight link aspError Error

let b:current_syntax = "asps"
