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
    DATA suffix TYPE string.
    IF number MOD 100 BETWEEN 11 AND 13.
        suffix = 'th'.
    ELSE.
        CASE number MOD 10.
            WHEN 1.
                suffix = 'st'.
            WHEN 2.
                suffix = 'nd'.
            WHEN 3.
                suffix = 'rd'.
            WHEN OTHERS.
                suffix = 'th'.
        ENDCASE.
     ENDIF.
         result = |{ name }, you are the { number }{ suffix } customer we serve today. Thank you!|.

  ENDMETHOD.
ENDCLASS.
