CLASS zcl_line_up DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS format IMPORTING name          TYPE string
                             number        TYPE i
                   RETURNING VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_line_up IMPLEMENTATION.
  METHOD format.
    IF number MOD 10 = 1 AND ( number < 10 OR number > 20 ).
        result = |{ name }, you are the { number }st customer we serve today. Thank you!|.
    ELSEIF number MOD 10 = 2 AND ( number < 10 OR number > 20 ).
        result = |{ name }, you are the { number }nd customer we serve today. Thank you!|.
    ELSEIF number MOD 10 = 3 AND ( number < 10 OR number > 20 ).
        result = |{ name }, you are the { number }rd customer we serve today. Thank you!|.
    ELSE.
        result = |{ name }, you are the { number }th customer we serve today. Thank you!|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
