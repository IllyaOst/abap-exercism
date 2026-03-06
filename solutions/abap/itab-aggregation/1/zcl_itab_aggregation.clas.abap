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

        READ TABLE aggregated_data WITH KEY group = num_str-group
        TRANSPORTING NO FIELDS.

        IF sy-subrc <> 0.
            APPEND VALUE #( group = num_str-group ) TO aggregated_data.
        ENDIF.

      LOOP AT aggregated_data ASSIGNING FIELD-SYMBOL(<fs_row>).

        IF num_str-group = <fs_row>-group.
          <fs_row>-count += 1.
          <fs_row>-sum += num_str-number.
          <fs_row>-average = <fs_row>-sum / <fs_row>-count.
          IF <fs_row>-count = 1.
            <fs_row>-min = num_str-number.
            <fs_row>-max = num_str-number.
          ELSE.
            IF <fs_row>-min > num_str-number.
              <fs_row>-min = num_str-number.
            ELSEIF <fs_row>-max < num_str-number.
              <fs_row>-max = num_str-number.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
