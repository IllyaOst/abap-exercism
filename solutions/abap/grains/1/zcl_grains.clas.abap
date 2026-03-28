CLASS zcl_grains DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.
    METHODS square
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_grains IMPLEMENTATION.
  METHOD square.
    IF input <= 0 OR input > 64.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.

    DATA result_int TYPE int8 VALUE 1.

    DO input - 1 TIMES.
        result_int = result_int * 2.
    ENDDO.

    result = result_int.
  ENDMETHOD.

  METHOD total.
  DATA result_int TYPE int8 VALUE 1.
    DO 63 TIMES.
    result_int = result_int * 2.
    result = result + result_int.
  ENDDO.
  ENDMETHOD.


ENDCLASS.
