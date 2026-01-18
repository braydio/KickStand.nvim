-- Override tablemode#TableizeRange to avoid E790 after undo.
vim.cmd([[
if exists('*tablemode#TableizeRange')
  function! s:ConvertDelimiterToSeparator(line, ...) abort
    let old_gdefault = &gdefault
    set nogdefault

    let delim = g:table_mode_delimiter
    if a:0 | let delim = a:1 | endif
    if delim ==# ','
      silent! execute a:line . 's/' . "[\'\"][^\'\"]*\\zs,\\ze[^\'\"]*[\'\"]/__COMMA__/g"
    endif

    let [cstart, cend] = [tablemode#table#GetCommentStart(), tablemode#table#GetCommentEnd()]
    let [match_char_start, match_char_end] = ['.', '.']
    if tablemode#utils#strlen(cend) > 0 | let match_char_end = '[^' . cend . ']' | endif
    if tablemode#utils#strlen(cstart) > 0 | let match_char_start = '[^' . cstart . ']' | endif

    silent! execute a:line . 's/' . tablemode#table#StartExpr() . '\zs\ze' . match_char_start .
          \ '\|' . delim .  '\|' . match_char_end . '\zs\ze' . tablemode#table#EndExpr() . '/' .
          \ g:table_mode_separator . '/g'

    if delim ==# ','
      silent! execute a:line . 's/' . "[\'\"][^\'\"]*\\zs__COMMA__\\ze[^\'\"]*[\'\"]/,/g"
    endif

    let &gdefault=old_gdefault
  endfunction

  function! s:Tableizeline(line, ...) abort
    let delim = g:table_mode_delimiter
    if a:0 && type(a:1) == type('') && !empty(a:1) | let delim = a:1[1:-1] | endif
    call s:ConvertDelimiterToSeparator(a:line, delim)
  endfunction

  function! tablemode#TableizeRange(...) range
    let lnum = a:firstline
    let total = (a:lastline - a:firstline + 1)
    let cntr = 1
    while cntr <= total
      call s:Tableizeline(lnum, a:1)
      silent! undojoin
      if g:table_mode_tableize_auto_border
        if cntr == 1
          normal! O
          call tablemode#table#AddBorder('.')
          normal! j
          let lnum += 1
        endif
        normal! o
        call tablemode#table#AddBorder('.')
        let lnum += 1
      endif
      let cntr += 1
      let lnum += 1
    endwhile

    call tablemode#table#Realign(lnum - 1)
  endfunction
endif
]])
