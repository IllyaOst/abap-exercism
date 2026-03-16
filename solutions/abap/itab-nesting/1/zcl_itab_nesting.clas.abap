CLASS zcl_itab_nesting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF artists_type,
             artist_id   TYPE string,
             artist_name TYPE string,
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.
    TYPES: BEGIN OF albums_type,
             artist_id  TYPE string,
             album_id   TYPE string,
             album_name TYPE string,
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.
    TYPES: BEGIN OF songs_type,
             artist_id TYPE string,
             album_id  TYPE string,
             song_id   TYPE string,
             song_name TYPE string,
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.


    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,
             song_name TYPE string,
           END OF song_nested_type.
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE string,
             album_name TYPE string,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type.
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,
             artist_name TYPE string,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type.
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists
        albums             TYPE albums
        songs              TYPE songs
      RETURNING
        VALUE(nested_data) TYPE nested_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting IMPLEMENTATION.

  METHOD perform_nesting.
LOOP AT artists INTO DATA(artists_s).
    DATA: song_nested_s         TYPE song_nested_type,
          album_song_nested_s   TYPE album_song_nested_type,
          artist_album_nested_s TYPE artist_album_nested_type.
        CLEAR artist_album_nested_s.
        artist_album_nested_s-artist_id = artists_s-artist_id.
        artist_album_nested_s-artist_name = artists_s-artist_name.
        LOOP AT albums INTO DATA(albums_s).
            CLEAR album_song_nested_s.
            IF artists_s-artist_id = albums_s-artist_id.
                album_song_nested_s-album_id = albums_s-album_id.
                album_song_nested_s-album_name = albums_s-album_name.
                LOOP AT songs INTO DATA(songs_s).
                CLEAR song_nested_s.
                IF albums_s-album_id = songs_s-album_id AND artists_s-artist_id = songs_s-artist_id.
                    song_nested_s-song_id = songs_s-song_id.
                    song_nested_s-song_name = songs_s-song_name.
                    APPEND song_nested_s TO album_song_nested_s-songs.
                ENDIF.
            ENDLOOP.
            APPEND album_song_nested_s TO artist_album_nested_s-albums.
            ENDIF.
        ENDLOOP.
        APPEND artist_album_nested_s TO nested_data.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
