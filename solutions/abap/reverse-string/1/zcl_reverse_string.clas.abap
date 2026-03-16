CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.
    DATA(len_input) = strlen( input ).

    DO len_input TIMES.
    DATA(ind) = len_input - sy-index.
    DATA(char) = input+ind(1).

    result = result && char.

    ENDDO.

  ENDMETHOD.

ENDCLASS.
