CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
     DATA(input_len) = strlen( input ).

    TYPES: BEGIN OF ty_score,
        char    TYPE c LENGTH 1,
        value   TYPE i,
       END OF ty_score.

    DATA: scores TYPE HASHED TABLE OF ty_score
             WITH UNIQUE KEY char.

   scores = VALUE #(
         ( char = 'D' value = 2 )
         ( char = 'G' value = 2 )
         ( char = 'B' value = 3 )
         ( char = 'C' value = 3 )
         ( char = 'M' value = 3 )
         ( char = 'P' value = 3 )
         ( char = 'F' value = 4 )
         ( char = 'H' value = 4 )
         ( char = 'V' value = 4 )
         ( char = 'W' value = 4 )
         ( char = 'Y' value = 4 )
         ( char = 'K' value = 5 )
         ( char = 'J' value = 8 )
         ( char = 'X' value = 8 )
         ( char = 'Q' value = 10 )
         ( char = 'Z' value = 10 ) ).

     DO input_len TIMES.
        DATA(ind)  = sy-index - 1.
        DATA(char) = to_upper( input+ind(1) ).

        READ TABLE scores INTO DATA(entry) WITH KEY char = char.
        IF sy-subrc = 0.
            result += entry-value.
        ELSE.
            result += 1.
        ENDIF.

     ENDDO.
  ENDMETHOD.

ENDCLASS.
