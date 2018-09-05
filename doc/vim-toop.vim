*vim-toop.txt*  Reduce the cognitive load by hiding irrelevant PHP syntax
*toop*

Author:  Jena Carlo Machado <https://jeancarlomachado.net/>

INTRODUCTION                                    *toop*

The most native way of extending your Vim.

Create custom text-object operations.

Toop stands for Text Objects OPerations. Or also Tim pOpe Original Project (with extensions).


Examples                                        *toop-examples*


    "make json objects beautiful
    call toop#mapShell('jq .', '<leader>jb')
    "unescape an object
    call toop#mapShell('sed "s/\\\//g" ', '<leader>u')



    "double quote
    call toop#mapAround("'", "<leader>'")
    "single quote
    call toop#mapAround('"', '<leader>"')
    "markdown italic
    call toop#mapAround('*', '<leader>it')
    "markdown bold
    call toop#mapAround('**', '<leader>bo')



    "using async
    fun! GoogleIt(str)
        execute 'AsyncRun $BROWSER "'.a:str.'"'
    endfunc
    call toop#mapFunction('GoogleIt', '<leader>gi')

    fun! FoldSomething(str)
        let comment=split(&commentstring, '%s')
        if len(l:comment)==1
            call add(comment, l:comment[0])
        endif
        return l:comment[0]." {{{\n".a:str."\n".l:comment[1]."}}}"
    endfun
    call toop#mapFunction('FoldSomething', '<leader>fo')




ABOUT                                           *toop-about*

Grab the latest version or report a bug on GitHub:

https://github.com/jeanCarloMachado/vim-toop

vim:tw=78:et:ft=help:norl:
