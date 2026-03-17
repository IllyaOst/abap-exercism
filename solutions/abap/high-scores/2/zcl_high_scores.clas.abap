CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD latest.

    DATA(ind) = lines( scores_list ).
    result = scores_list[ ind ].

  ENDMETHOD.

  METHOD list_scores.
    result = scores_list.
  ENDMETHOD.

  METHOD personalbest.
    DATA max TYPE i.
    LOOP AT scores_list INTO DATA(num).
        IF num > max.
            max = num.
        ENDIF.
    ENDLOOP.
    result = max.
  ENDMETHOD.

  METHOD personaltopthree.
    SORT scores_list BY table_line DESCENDING.
    LOOP AT scores_list INTO DATA(num) FROM 1 TO 3.
        APPEND num TO result.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.
