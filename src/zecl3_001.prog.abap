*&---------------------------------------------------------------------*
*& Report ZECL3_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZECL3_001.
TABLES: ztrn_t001 , ztrn_t002 , ztrn_t005, ztrn_t006, ztrn_t007.

DATA :

  lv_min   TYPE i,

  sayac    TYPE i,

  lv_min2  TYPE i,

  lv_max   TYPE i,

  lv_max2  TYPE i,

  lv_index TYPE i,

  lv_rnd   TYPE i,

  lv_rnd2  TYPE i,

  lv_i     TYPE i.

DATA: gt_trn1     TYPE TABLE OF ztrn_t001,

      gs_trn1     TYPE ztrn_t001,

      ps_selfield TYPE slis_selfield,

      gt_trn2     TYPE TABLE OF ztrn_t002,

      gs_trn2     TYPE ztrn_t002,

      gs_trn6     TYPE ztrn_t006,

      gs_trn7     TYPE ztrn_t007,

      gt_trn3     TYPE TABLE OF ztrn_t003,

      gt_trn6     TYPE TABLE OF ztrn_t006,

      gt_trn7     TYPE TABLE OF ztrn_t007,

      gs_trn3     TYPE ztrn_t003.

DATA: gs_trn4 TYPE ztrn_t005,

      gt_trn4 TYPE TABLE OF ztrn_t005.

lv_min = 1.

lv_min2 = 1.

lv_max = 40.

lv_max2 = 20.

lv_i = 2.

DO 1 TIMES.

  SELECT *  FROM ztrn_t002 INTO TABLE gt_trn2  WHERE deletelog EQ space.

  SELECT * FROM ztrn_t001 INTO TABLE gt_trn1 WHERE deletelog EQ space.

  IF gt_trn2 IS INITIAL.

    MESSAGE 'Tüm takımlar dolu.' TYPE 'I' DISPLAY LIKE 'S'.

    EXIT.

  ENDIF.

  DESCRIBE TABLE gt_trn2 LINES lv_max2.

  DESCRIBE TABLE gt_trn1 LINES lv_max.

  DATA ls_line TYPE ztrn_t002.

  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max   = lv_max2
      ran_int_min   = lv_min2
    IMPORTING
      ran_int       = lv_rnd2
    EXCEPTIONS
      invalid_input = 1
      OTHERS        = 2.

  ls_line = gt_trn2[ lv_rnd2  ].

  SELECT * FROM ztrn_t003 INTO TABLE gt_trn3.

  SELECT * FROM ztrn_t005 INTO TABLE gt_trn4.

  SELECT * FROM ztrn_t006 INTO TABLE gt_trn6.

  SELECT * FROM ztrn_t007 INTO TABLE gt_trn7.

  DESCRIBE TABLE gt_trn7 LINES sayac.

  SORT gt_trn3 ASCENDING BY teamid.

  IF ls_line IS NOT INITIAL.

    IF gt_trn1 IS NOT INITIAL.

      lv_i = 2.

      DO  2 TIMES.

        DESCRIBE TABLE gt_trn1 LINES lv_max.

        DATA ls_line1 TYPE ztrn_t001.

        CALL FUNCTION 'QF05_RANDOM_INTEGER'
          EXPORTING
            ran_int_max   = lv_max
            ran_int_min   = lv_min
          IMPORTING
            ran_int       = lv_rnd
          EXCEPTIONS
            invalid_input = 1
            OTHERS        = 2.

        ls_line1 = gt_trn1[ lv_rnd ].

        IF sy-subrc NE 0.

        ELSE.

          lv_i =   lv_i - 1.

          gs_trn3-personid = ls_line1-id.

          gs_trn3-pname = ls_line1-name.

          gs_trn3-psurname = ls_line1-surname.

          gs_trn3-teamid = ls_line-teamid.

          APPEND gs_trn3 TO gt_trn3.

          MODIFY ztrn_t003 FROM gs_trn3.

          ls_line-deletelog = 'X'.

          MODIFY ztrn_t002 FROM ls_line.

          COMMIT WORK AND WAIT.

          IF ls_line1-deletelog NE 'X'.

            ls_line1-deletelog = 'X'.

            MODIFY ztrn_t001 FROM ls_line1.

            COMMIT WORK AND WAIT.

          ENDIF.

        ENDIF.

        IF gs_trn7-teamid1 EQ space.

          IF sayac = 0.

            gs_trn7-matchh = 'A'.

          ELSEIF sayac = 1.

            gs_trn7-matchh = 'B'.

          ELSEIF sayac = 2.

            gs_trn7-matchh = 'C'.

          ELSEIF sayac = 3.

            gs_trn7-matchh = 'D'.

          ELSEIF sayac = 4.

            gs_trn7-matchh = 'E'.

          ELSEIF sayac = 5.

            gs_trn7-matchh = 'F'.

          ELSEIF sayac = 6.

            gs_trn7-matchh = 'G'.

          ELSEIF sayac = 7.

            gs_trn7-matchh = 'H'.

          ENDIF.

          gs_trn7-teamid1 = ls_line-teamid.

          gs_trn7-teamname1 = ls_line-teamname.

          gs_trn7-personid11 = ls_line1-id.

          gs_trn7-pname11 = ls_line1-name.

          gs_trn7-psurname11 = ls_line1-surname.

          DELETE gt_trn1 WHERE id = ls_line1-id.

        ELSE.

          gs_trn7-personid12 = ls_line1-id.

          gs_trn7-pname12 = ls_line1-name.

          gs_trn7-psurname12 = ls_line1-surname.

          DELETE gt_trn2 WHERE teamid = ls_line-teamid.

          DELETE gt_trn1 WHERE id = ls_line1-id.

          DELETE gt_trn7 WHERE personid12 = 0.

        ENDIF.

        APPEND gs_trn7 TO gt_trn7.

        MODIFY ztrn_t007 FROM gs_trn7.

        COMMIT WORK AND WAIT.

      ENDDO.

      DESCRIBE TABLE gt_trn2 LINES lv_max2.

      DESCRIBE TABLE gt_trn1 LINES lv_max.

      DATA ls_line2 TYPE ztrn_t002.

      CALL FUNCTION 'QF05_RANDOM_INTEGER'
        EXPORTING
          ran_int_max   = lv_max2
          ran_int_min   = lv_min2
        IMPORTING
          ran_int       = lv_rnd2
        EXCEPTIONS
          invalid_input = 1
          OTHERS        = 2.

      ls_line2 = gt_trn2[ lv_rnd2  ].

      IF ls_line2 IS NOT INITIAL.

        IF gt_trn1 IS NOT INITIAL.

          lv_i = 2.

          DO 2 TIMES.

            DESCRIBE TABLE gt_trn1 LINES lv_max.

            DATA ls_line11 TYPE ztrn_t001.

            CALL FUNCTION 'QF05_RANDOM_INTEGER'
              EXPORTING
                ran_int_max   = lv_max
                ran_int_min   = lv_min
              IMPORTING
                ran_int       = lv_rnd
              EXCEPTIONS
                invalid_input = 1
                OTHERS        = 2.

            ls_line11 = gt_trn1[ lv_rnd ].

            lv_i =   lv_i - 1.

            IF gs_trn7-teamid2 EQ space.

              gs_trn7-teamid2 = ls_line2-teamid.

              gs_trn7-teamname2 = ls_line2-teamname.

              gs_trn7-personid21 = ls_line11-id.

              gs_trn7-pname21 = ls_line11-name.

              gs_trn7-psurname21 = ls_line11-surname.

              DELETE gt_trn7 WHERE matchh EQ space.

              DELETE gt_trn1 WHERE id = ls_line11-id.

              IF ls_line11-deletelog NE 'X'.

                ls_line11-deletelog = 'X'.

                MODIFY ztrn_t001 FROM ls_line11.

                COMMIT WORK AND WAIT.

              ENDIF.

              IF ls_line2-deletelog NE 'X'.

                ls_line2-deletelog = 'X'.

                MODIFY ztrn_t002 FROM ls_line2.

                COMMIT WORK AND WAIT.

              ENDIF.

            ELSE.

              gs_trn7-personid22 = ls_line11-id.

              gs_trn7-pname22 = ls_line11-name.

              gs_trn7-psurname22 = ls_line11-surname.

              DELETE gt_trn2 WHERE teamid = ls_line2-teamid.

              DELETE gt_trn1 WHERE id = ls_line11-id.

              DELETE gt_trn7 WHERE personid22 = 0.

              IF ls_line11-deletelog NE 'X'.

                ls_line11-deletelog = 'X'.

                MODIFY ztrn_t001 FROM ls_line11.

                COMMIT WORK AND WAIT.

              ENDIF.

            ENDIF.

            APPEND gs_trn7 TO gt_trn7.

            MODIFY ztrn_t007 FROM gs_trn7.

            COMMIT WORK AND WAIT.

          ENDDO.

        ENDIF.

      ENDIF.

    ENDIF.

    MODIFY ztrn_t001 FROM ls_line1.

    MODIFY ztrn_t002 FROM ls_line.

    COMMIT WORK AND WAIT.

    IF gs_trn4-teamid1 EQ space.

      gs_trn4-teamid1 = ls_line-teamid.

      gs_trn4-teamname1 = ls_line-teamname.

      gs_trn2-teamid  = gs_trn4-teamid1.

      gs_trn2-teamname = gs_trn4-teamname1.

    ELSE.

      gs_trn2-deletelog = ' '.

      gs_trn4-teamid2 = ls_line-teamid.

      gs_trn4-teamname2 = ls_line-teamname.

      gs_trn2-teamid  = gs_trn4-teamid2.

      gs_trn2-teamname = gs_trn4-teamname2.

      DELETE gt_trn2 WHERE teamid = ls_line-teamid.

      COMMIT WORK AND WAIT.

    ENDIF.

    MODIFY ztrn_t005 FROM gs_trn4.

    DELETE FROM ztrn_t005  WHERE teamid2 = 0.

    COMMIT WORK AND WAIT.

    IF gs_trn2-deletelog NE 'X'.

      gs_trn2-deletelog = 'X'.

      MODIFY ztrn_t002 FROM gs_trn2.

      COMMIT WORK AND WAIT.

    ENDIF.

  ENDIF.

ENDDO.
