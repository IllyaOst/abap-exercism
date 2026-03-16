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

      DO input_len TIMES.

      DATA(ind) = sy-index - 1.
      DATA(char) = to_upper( input+ind(1) ).

          CASE char.
            WHEN 'D' OR 'G'.
                result += 2.
            WHEN 'B' OR 'C' OR 'M' OR 'P'.
                result += 3.
            WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
                result += 4.
            WHEN 'K'.
                result += 5.
            WHEN 'J' OR 'X'.
                result += 8.
            WHEN 'Q' OR 'Z'.
                result += 10.
            WHEN OTHERS.
                result += 1.
          ENDCASE.
      ENDDO.
  ENDMETHOD.

ENDCLASS.
