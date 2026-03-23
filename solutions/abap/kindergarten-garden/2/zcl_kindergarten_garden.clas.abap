CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.

ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.


  METHOD plants.
    DATA: result_vor    TYPE string,
          row1          TYPE string,
          row2          TYPE string.
    DATA(students) = VALUE string_table(  "string_table = standard internal table of string
    ( |Alice| ) ( |Bob| ) ( |Charlie| ) ( |David| ) ( |Eve| )
    ( |Fred| ) ( |Ginny| ) ( |Harriet| ) ( |Ileana| ) ( |Joseph| )
    ( |Kincaid| ) ( |Larry| )
    ).

    SPLIT diagram AT '\n' INTO row1 row2.

    DATA(idx) = ( line_index( students[ table_line = student ] ) - 1 ) * 2.

          result_vor = row1+idx(2) && row2+idx(2).

          results = VALUE string_table(
            FOR i = 0 UNTIL i = 4
            LET c = result_vor+i(1)
            IN
                ( SWITCH string( c
                    WHEN 'G' THEN 'grass'
                    WHEN 'C' THEN 'clover'
                    WHEN 'R' THEN 'radishes'
                    WHEN 'V' THEN 'violets' ) )
                        ).
  ENDMETHOD.


ENDCLASS.
