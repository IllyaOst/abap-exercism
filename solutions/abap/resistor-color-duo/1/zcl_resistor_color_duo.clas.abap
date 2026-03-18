CLASS zcl_resistor_color_duo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS value
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_resistor_color_duo IMPLEMENTATION.
  METHOD value.
    LOOP AT colors INTO DATA(color) FROM 1 TO 2.
    CASE color.
        WHEN 'black'.
            result = result && '0'.
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
  ENDLOOP.
  ENDMETHOD.
ENDCLASS.
