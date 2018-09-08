let s:shellF = {}

function! toop#mapShell(surround, key)
    let indice = len(s:shellF) + 1
    let s:shellF['f_'.indice] = function('s:runShell', [a:surround])
    execute 'let s:fs_'.indice.' =  s:shellF["f_'.indice.'"]'
    call toop#mapFunction('s:fs_'.indice, a:key)
endfun

function! s:runShell(cmd, text)
    let out = system(a:cmd, a:text)
    return out
endfun

function! toop#mapAround(left, right, key)
    let indice = len(s:shellF) + 1
    let s:shellF['f_'.indice] = function('s:runAround', [a:left, a:right])
    execute 'let s:af_'.indice.' =  s:shellF["f_'.indice.'"]'
    call toop#mapFunction('s:af_'.indice, a:key)
endfun

function! s:runAround(left, right, text)
    return a:left.a:text.a:right
endfun

function! toop#mapFunction(algorithm, key)
    exe 'nnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call toop#ActionSetup("'.a:algorithm.'")<CR>g@'
    exe 'xnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call toop#DoAction("'.a:algorithm.'",visualmode())<CR>'
    exe 'nnoremap <silent> <Plug>actionsLine'.a:algorithm.' :<C-U>call toop#DoAction("'.a:algorithm.'",v:count1)<CR>'
    exe 'nmap '.a:key.'  <Plug>actions'.a:algorithm
    exe 'xmap '.a:key.'  <Plug>actions'.a:algorithm
    exe 'nmap '.a:key.a:key[strlen(a:key)-1].' <Plug>actionsLine'.a:algorithm
endfun

fun! ActionOpfunc(type)
    return toop#DoAction(s:encode_algorithm, a:type)
endfun

fun! toop#ActionSetup(algorithm)
    let s:encode_algorithm = a:algorithm
    let &opfunc = matchstr(expand('<sfile>'), '<SNR>\d\+_').'ActionOpfunc'
endfun

fun! s:lastChar(str)
    let indice = len(a:str) - 1
    return strcharpart(a:str, indice)
endfun

fun! toop#DoAction(algorithm,type)
    let s:currentAlgo = a:algorithm
    " backup settings that we will change
    let sel_save = &selection
    let cb_save = &clipboard
    " make selection and clipboard work the way we need
    set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
    " backup the unnamed register, which we will be yanking into
    let reg_save = @@
    " yank the relevant text, and also set the visual selection (which will be reused if the text
    " needs to be replaced)
    if a:type =~ '^\d\+$'
        " if type is a number, then select that many lines
        silent exe 'normal! V'.a:type.'$y'
    elseif a:type =~ '^.$'
        " if type is 'v', 'V', or '<C-V>' (i.e. 0x16) then reselect the visual region
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        " line-based text motion
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        " block-based text motion
        silent exe "normal! `[\<C-V>`]y"
    else
        " char-based text motion
        silent exe "normal! `[v`]y"
    endif
    " call the user-defined function, passing it the contents of the unnamed register
    let input = @@
    let result = {a:algorithm}(input)
    " call ShowStringOnNewWindow(result)

    " if the last char is a new line only in the result drop it
    "  since most shell commands print their reuslts with new lines
    "  in the end
    if (s:lastChar(result) == "\n" && s:lastChar(input) != "\n")
        let result = strcharpart(result, 0, (len(result) - 1))
    endif

    " if the function returned a value, then replace the text
    if type(result) == 1
        " put the replacement text into the unnamed register, and also set it to be a
        " characterwise, linewise, or blockwise selection, based upon the selection type of the
        " yank we did above
        call setreg('@', result, getregtype('@'))
        " relect the visual region and paste
        normal! gvp
    endif
    " restore saved settings and register value
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cb_save
endfun

fun! ShowStringOnNewWindow(content)
    split _output_
    normal! ggdG
    setlocal buftype=nofile
    call append(0, split(a:content, '\v\n'))
endfun

