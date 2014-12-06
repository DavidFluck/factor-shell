USING: fry io kernel sequences sets splitting unix.process system io.launcher formatting io.pathnames io.files.private combinators ;
IN: factor-shell

: make-prompt ( -- str )
    { } cwd suffix "$ " suffix "" join ;

: print-prompt ( -- )
    make-prompt write flush ;

: tokenize-line ( str -- seq )
    " " split ;

: exit-maybe ( x -- x )
    dup "exit" = [ 0 exit ] [ ] if ;

: factor-shell ( -- )
     [ t ] [ print-prompt readln exit-maybe tokenize-line 
     { 
       { [ dup first "cd" = ] [ 1 tail " " join cd ] } 
       { [ dup last "&" = ] [ 1 head* " " join run-detached drop ] } 
       [ " " join run-process wait-for-process drop ] 
     } cond ] while ;

MAIN: factor-shell