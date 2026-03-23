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
    DATA: count         TYPE i,
          result_vor    TYPE string,
          row1          TYPE string,
          row2          TYPE string.
    DATA(students) = VALUE string_table(  "string_table = standard internal table of string
    ( |Alice| ) ( |Bob| ) ( |Charlie| ) ( |David| ) ( |Eve| )
    ( |Fred| ) ( |Ginny| ) ( |Harriet| ) ( |Ileana| ) ( |Joseph| )
    ( |Kincaid| ) ( |Larry| )
    ).

    SPLIT diagram AT '\n' INTO row1 row2.

    LOOP AT students INTO DATA(person).
          count += 1.
              IF person = student.
                DATA(ind) = ( count - 1 ) * 2.
                result_vor = row1+ind(2) && row2+ind(2).
              ENDIF.
          ENDLOOP.
          ind = 0.
          DO 4 TIMES.
            CASE result_vor+ind(1).
                WHEN 'G'.
                    APPEND 'grass' TO results.
                WHEN 'C'.
                    APPEND 'clover' TO results.
                WHEN 'R'.
                    APPEND 'radishes' TO results.
                WHEN 'V'.
                    APPEND 'violets' TO results.
            ENDCASE.
            ind += 1.
*            IF result_vor+ind(1) = 'G'.
*                APPEND 'Grass' TO results.
*
*            ENDIF.
          ENDDO.
  ENDMETHOD.


ENDCLASS.
