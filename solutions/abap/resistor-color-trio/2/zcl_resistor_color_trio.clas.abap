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
    DATA: result_p TYPE p,
          color_map TYPE STANDARD TABLE OF string .

  "Mapping table
  color_map = VALUE #(
        ( `black` ) ( `brown` ) ( `red` ) ( `orange` ) ( `yellow` )
        ( `green` ) ( `blue` ) ( `violet` ) ( `grey` ) ( `white` ) ).

  "First two digits
  DATA(d1) = line_index( color_map[ table_line = colors[ 1 ] ] ) - 1.
  DATA(d2) = line_index( color_map[ table_line = colors[ 2 ] ] ) - 1.

  result = |{ d1 }{ d2 }|.

  "Multiplier third digit
  DATA(multiplier) = line_index( color_map[ table_line = colors[ 3 ] ] ) - 1.
  result_p = result * ( 10 ** multiplier ).

  "Format
  IF result_p >= 1000000000.
    result = |{ result_p / 1000000000 } gigaohms|.
  ELSEIF result_p >= 1000000.
    result = |{ result_p / 1000000 } megaohms|.
  ELSEIF result_p >= 1000.
    result = |{ result_p / 1000 } kiloohms|.
  ELSE.
    result = |{ result_p } ohms|.
  ENDIF.
  ENDMETHOD.
ENDCLASS.
