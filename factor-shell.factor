USING: fry io kernel sequences sets splitting unix.process system io.launcher formatting ;
IN: factor-shell

: print-prompt ( -- )
    "thing> " printf flush ;

: tokenize-lines ( str -- seq )
    " " split ;

: factor-shell ( -- )
    [ 0 0 = ] [ print-prompt readln dup "exit" = [ 0 exit ] [ ] if run-process wait-for-process drop  ] while ;

MAIN: factor-shell