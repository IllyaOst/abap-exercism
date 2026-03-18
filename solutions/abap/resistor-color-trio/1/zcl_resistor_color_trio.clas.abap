CLASS zcl_resistor_color_trio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS label
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_resistor_color_trio IMPLEMENTATION.
  METHOD label.
    LOOP AT colors INTO DATA(color).
  IF sy-tabix < 3.
    CASE color.
        WHEN 'black'.
            IF sy-tabix = 1.
            result = result.
            ELSE.
            result = result && '0'.
            ENDIF.
        WHEN 'brown'.
            result = result && '1'.
        WHEN 'red'.
            result = result && '2'.
        WHEN 'orange'.
            result = result && '3'.
        WHEN 'yellow'.
            result = result && '4'.
        WHEN 'green'.
            result = result && '5'.
        WHEN 'blue'.
            result = result && '6'.
        WHEN 'violet'.
            result = result && '7'.
        WHEN 'grey'.
            result = result && '8'.
        WHEN 'white'.
            result = result && '9'.
    ENDCASE.
  ELSEIF sy-tabix = 3.
    CASE color.
        WHEN 'black'.
            result = result.
        WHEN 'brown'.
            result = result && '0'.
        WHEN 'red'.
            result = result && '00'.
        WHEN 'orange'.
            result = result && '000'.
        WHEN 'yellow'.
            result = result && '0000'.
        WHEN 'green'.
            result = result && '00000'.
        WHEN 'blue'.
            result = result && '000000'.
        WHEN 'violet'.
            result = result && '0000000'.
        WHEN 'grey'.
            result = result && '00000000'.
        WHEN 'white'.
            result = result && '000000000'.
    ENDCASE.
    IF result >= 1000 AND result < 1000000.
        result = |{ result / 1000 } kiloohms|.
    ELSEIF result >= 1000000 AND result < 1000000000.
        result = |{ result / 1000000 } megaohms|.
    ELSEIF result >= 1000000000.
        result = |{ result / 1000000000 } gigaohms|.
    ELSE.
        result = |{ result } ohms|.
    ENDIF.
    EXIT.

  ENDIF.
  ENDLOOP.
  ENDMETHOD.
ENDCLASS.
