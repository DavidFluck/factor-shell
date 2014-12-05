USING: fry io kernel sequences sets splitting unix.process ;
IN: factor-shell

: print-prompt ( -- )
    "thing" print ;

: tokenize-lines ( str -- seq )
    " " split ;

: run-command ( seq -- )
    "junk" [ first ] keep '[ "child" print flush  _ _ exec drop ] [ flush drop drop "junker" ] with-fork drop ;

: factor-shell ( -- )
    "yo" print flush [ "exit" = ] [ readln dup tokenize-lines run-command "loopin" print flush ] do until ;

MAIN: factor-shell