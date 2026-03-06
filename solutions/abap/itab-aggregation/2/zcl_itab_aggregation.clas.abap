CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
        LOOP AT initial_numbers INTO DATA(num_str).

        READ TABLE aggregated_data
        ASSIGNING FIELD-SYMBOL(<fs_row>)
        WITH KEY group = num_str-group.

        IF sy-subrc <> 0.

            APPEND VALUE #(
            group = num_str-group
            count = 1
            sum = num_str-number
            average = num_str-number
            min = num_str-number
            max = num_str-number
            ) TO aggregated_data.

        ELSE.

          <fs_row>-count    += 1.
          <fs_row>-sum      += num_str-number.
          <fs_row>-average  = <fs_row>-sum / <fs_row>-count.

          <fs_row>-min = COND #(
            WHEN num_str-number < <fs_row>-min
            THEN num_str-number
            ELSE <fs_row>-min ).

          <fs_row>-max = COND #(
            WHEN num_str-number > <fs_row>-max
            THEN num_str-number
            ELSE <fs_row>-max ).

        ENDIF.


    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
