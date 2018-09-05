
function! toop#mapFunction(algorithm, key)
    exe 'nnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call toop#ActionSetup("'.a:algorithm.'")<CR>g@'
    exe 'xnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call toop#DoAction("'.a:algorithm.'",visualmode())<CR>'
    exe 'nnoremap <silent> <Plug>actionsLine'.a:algorithm.' :<C-U>call toop#DoAction("'.a:algorithm.'",v:count1)<CR>'
    exe 'nmap '.a:key.'  <Plug>actions'.a:algorithm
    exe 'xmap '.a:key.'  <Plug>actions'.a:algorithm
    exe 'nmap '.a:key.a:key[strlen(a:key)-1].' <Plug>actionsLine'.a:algorithm
endfun


function! s:runShell(cmd, text)
    let out = system(a:cmd, a:text)
    return out
endfun


function! toop#mapShell(cmd, key)
    let Cb = function('s:runShell', [a:cmd])
    call toop#mapFunction('s:Cb', a:key)
endfun

function! s:myAround(surround, text)
    return a:surround.''.a:text.''.a:surround
endfun

let s:funcs = {}

function! toop#mapAround(surround, key)
    let indice = len(s:funcs) + 1

    let s:funcs['f_'.indice] = function('s:myAround', [a:surround])
    execute 'let s:f_'.indice.' =  s:funcs["f_'.indice.'"]'
    call toop#mapFunction('s:f_'.indice, a:key)
endfun



"only works with s:
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
    let repl = {a:algorithm}(Chomp(@@))
    " if the function returned a value, then replace the text
    if type(repl) == 1
        " put the replacement text into the unnamed register, and also set it to be a
        " characterwise, linewise, or blockwise selection, based upon the selection type of the
        " yank we did above
        call setreg('@', repl, getregtype('@'))
        " relect the visual region and paste
        normal! gvp
    endif
    " restore saved settings and register value
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cb_save
endfun

fun! ActionOpfunc(type)
    return toop#DoAction(s:encode_algorithm, a:type)
endfun

fun! toop#ActionSetup(algorithm)
    let s:encode_algorithm = a:algorithm
    let &opfunc = matchstr(expand('<sfile>'), '<SNR>\d\+_').'ActionOpfunc'
endfun
