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
    DATA: top1 TYPE i,
          top2 TYPE i,
          top3 TYPE i.
     LOOP AT scores_list INTO DATA(number).

        IF number >= top1.
            IF top2 IS NOT INITIAL.
                top3 = top2.
            ENDIF.
            IF top1 IS NOT INITIAL.
                top2 = top1.
            ENDIF.
            top1 = number.

        ELSEIF top1 > number AND number >= top2.
            IF top2 IS NOT INITIAL.
                top3 = top2.
            ENDIF.
            top2 = number.
        ELSEIF top2 > number AND number >= top3.
            top3 = number.
        ENDIF.
     ENDLOOP.
     APPEND top1 TO result.
     IF top2 IS NOT INITIAL.
        APPEND top2 TO result.
     ENDIF.
     IF top3 IS NOT INITIAL.
        APPEND top3 TO result.
     ENDIF.
  ENDMETHOD.


ENDCLASS.
