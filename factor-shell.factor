USING: fry io kernel sequences sets splitting unix.process system io.launcher formatting ;
IN: factor-shell

: print-prompt ( -- )
    "thing> " printf flush ;

: tokenize-lines ( str -- seq )
    " " split ;

: factor-shell ( -- )
    [ "exit" = ] [ print-prompt readln dup run-process wait-for-process drop  ] do until ;

MAIN: factor-shell