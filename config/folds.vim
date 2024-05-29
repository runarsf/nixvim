" https://vi.stackexchange.com/q/5658

function! MoveAndFoldLeft()
  let line = getpos('.')[1]
  let col  = getpos('.')[2]

  if l:col ==# 1 && foldlevel(l:line)
    execute "foldclose"
  else
    execute "normal! h"
  endif
endfunction

function! MoveAndFoldRight()
  let line = getpos('.')[1]

  if foldlevel(line) && foldclosed(line) != -1
    execute "foldopen"
  else
    execute "normal! l"
  endif
endfunction

function! MoveAndFoldVert(dir)
  let pos = getcurpos()[1]
  " FIXME Don't close if the entered line was open
  "  let was = foldclosed(l:nxt)
  " TODO Allow only folding foldlevel 1 automatically so you get to see a whole Class with methods
  let nxt = l:pos + a:dir
  let src = foldlevel(l:pos)
  let dst = foldlevel(l:nxt)

  if l:src < l:dst
    exec l:nxt . "foldopen"
  elseif l:src > l:dst
    exec l:pos . "foldclose"
  endif
  exec ":" . l:nxt
endfunction

function! AutoFold()
  if exists("g:autofold_enabled")
    echom "Disabling auto-fold"
    unlet g:autofold_enabled
    unmap <Down>
    unmap j
    unmap <Up>
    unmap k
  else
    echom "Enabling auto-fold"
    let g:autofold_enabled = 1
    nnoremap <silent> <Down>  <CMD>call MoveAndFoldVert(1)<CR>
    nnoremap <silent> j       <CMD>call MoveAndFoldVert(1)<CR>
    nnoremap <silent> <Up>    <CMD>call MoveAndFoldVert(-1)<CR>
    nnoremap <silent> k       <CMD>call MoveAndFoldVert(-1)<CR>
  endif
endfunction

nnoremap <silent> <Left>  <CMD>call MoveAndFoldLeft()<CR>
nnoremap <silent> h       <CMD>call MoveAndFoldLeft()<CR>
nnoremap <silent> <Right> <CMD>call MoveAndFoldRight()<CR>
nnoremap <silent> l       <CMD>call MoveAndFoldRight()<CR>

