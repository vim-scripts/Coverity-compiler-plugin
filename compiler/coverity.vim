" Vim Compiler File
" Compiler:     cov-format-errors for Coverity Static Analysis
" Maintainer:   Ben Fritz
" Last Change:  14 Feb 2012
" Version:      1

if exists("current_compiler")
  finish
endif
let current_compiler = "coverity"

" Define the ComplierSet command if it does not exist.
" older Vim always used :setlocal
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

" get emit directory for Coverity to parse
if exists('b:coverity_emit_dir') && b:coverity_emit_dir!=''
  let s:coverity_emit_dir=b:coverity_emit_dir
else
  if v:version >= 700
    let s:coverity_emit_dir=input("Enter path to Coverity emit directory: ", '', 'file')
  else
    let s:coverity_emit_dir=input("Enter path to Coverity emit directory: ", '')
  endif
endif
" TODO: use shellescape on the emit directory name?

CompilerSet errorformat=%Zcaretline:\ %p^,%EError:\ %m,%C%f:%l:,%I%f:%l:,%Z%m
exe 'CompilerSet makeprg=cov-format-errors\ --emacs-style\ --dir\ '.s:coverity_emit_dir
