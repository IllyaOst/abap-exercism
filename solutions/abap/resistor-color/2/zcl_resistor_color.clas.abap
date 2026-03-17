CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.

  METHOD resistor_color.
TYPES: BEGIN OF colors_value,
            name TYPE string,
            value TYPE i,
           END OF colors_value.
    DATA table TYPE HASHED TABLE OF colors_value WITH UNIQUE KEY name.
    table = VALUE #(
                    ( name = 'black'    value = 0 )
                    ( name = 'brown'    value = 1 )
                    ( name = 'red'      value = 2 )
                    ( name = 'orange'   value = 3 )
                    ( name = 'yellow'   value = 4 )
                    ( name = 'green'    value = 5 )
                    ( name = 'blue'     value = 6 )
                    ( name = 'violet'   value = 7 )
                    ( name = 'grey'     value = 8 )
                    ( name = 'white'    value = 9 ) ).
    READ TABLE table INTO DATA(rez) WITH KEY name = color_code.
    value = rez-value.
  ENDMETHOD.

ENDCLASS.
