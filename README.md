# Toop

The most native way of extending your Vim.
Toop stands for Text Objects OPerations. Or also Tim pOpe Original Project (with extensions).


It's the easiest way of creating "native-like" behaviour to your vim.


## Usage Examples

```vim
"unescape an object
call toop#mapShell('sed "s/\\\//g" ', '<leader>u')


"markdown bold
call toop#mapAround('**', '<leader>bo')



fun! FoldSomething(str)
    let comment=split(&commentstring, '%s')
    if len(l:comment)==1
        call add(comment, l:comment[0])
    endif
    return l:comment[0]." {{{\n".a:str."\n".l:comment[1]."}}}"
endfun

call toop#mapFunction('FoldSomething', '<leader>fo')



"using async
fun! GoogleIt(str)
    execute 'AsyncRun run_function googleIt "'.a:str.'"'
endfunc


```

