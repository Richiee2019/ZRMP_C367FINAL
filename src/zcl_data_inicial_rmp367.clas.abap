CLASS zcl_data_inicial_rmp367 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_inicial_rmp367 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_in TYPE TABLE OF zbdt_inc_rmp367.
    DATA: ls_in TYPE zbdt_inc_rmp367.
    DATA: lt_inh TYPE TABLE OF zbdt_in_h_rmp367.
    DATA: lt_inp TYPE TABLE OF zbdt_pri_rmp367.
    DATA: lt_ins TYPE TABLE OF zbdt_est_rmp367.


    DELETE FROM zbdt_inc_rmp367.
    DELETE FROM zbdt_in_h_rmp367.
    DELETE FROM zbdt_pri_rmp367.
    DELETE FROM zbdt_est_rmp367.

    DATA(lv_uuid) = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
                  inc_uuid                = lv_uuid
                  incident_id             = 1
                  title                   = 'Incidente Uno'
                  description             = 'Registro Incidente 1'
                  status                  = 'OP'
                  priority                = 'L'
                  creation_date           = sy-datum
                  changed_date            = sy-datum
                  local_created_by        = sy-uname
                  local_created_at        = ''
                  local_last_changed_by   = ''
                  local_last_changed_at   = ''
                  last_changed_at         = ''

    ) TO lt_in.

    MODIFY zbdt_inc_rmp367 FROM TABLE @lt_in.

    IF sy-subrc EQ 0.

      out->write( |Registro insertado { sy-dbcnt } Indicente| ).
    ENDIF.

    DATA(lv_uuidh) = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
                        his_uuid            =  lv_uuidh
                        inc_uuid              = lv_uuid
                        his_id                = 1
                        previous_status       = ''
                        new_status            = 'OP'
                        text                  = 'Primer estatus'
                        local_created_by      = sy-uname
                        local_created_at      = sy-datum
                        local_last_changed_by = ''
                        local_last_changed_at = ''
                        last_changed_at       = ''
                    ) TO lt_inh.


    MODIFY zbdt_in_h_rmp367 FROM TABLE @lt_inh.



    IF sy-subrc EQ 0.
      out->write( |Registro insertado { sy-dbcnt } Historial| ).
    ENDIF.


    APPEND VALUE #(
                    status_code         = 'OP'
                    status_description  = 'OPEN'
                  ) TO lt_ins.
    APPEND VALUE #(
                    status_code         = 'IP'
                    status_description  = 'IN PROGRESS'
                  ) TO lt_ins.
    APPEND VALUE #(
                    status_code         = 'PE'
                    status_description  = 'PENDING'
                    ) TO lt_ins.
    APPEND VALUE #(
                    status_code         = 'CO'
                    status_description  = 'COMPLETED'
                  ) TO lt_ins.
    APPEND VALUE #(
                    status_code         = 'CL'
                    status_description  = 'CLOSED'
                    ) TO lt_ins.
    APPEND VALUE #(
                    status_code         = 'CN'
                    status_description  = 'CANCELED'
                  ) TO lt_ins.

    MODIFY zbdt_est_rmp367 FROM TABLE @lt_ins.

    IF sy-subrc EQ 0.
      out->write( |Registro insertado { sy-dbcnt } Estatus| ).
    ENDIF.

    APPEND VALUE #(
                    priority_code        = 'H'
                    priority_description  = 'COMPLETED'
                  ) TO lt_inp.
    APPEND VALUE #(
                    priority_code         = 'M'
                    priority_description  = 'CLOSED'
                    ) TO lt_inp.
    APPEND VALUE #(
                    priority_code         = 'L'
                    priority_description  = 'CANCELED'
                  ) TO lt_inp.

    MODIFY zbdt_pri_rmp367 FROM TABLE @lt_inp.

    IF sy-subrc EQ 0.
      out->write( |Registro insertado { sy-dbcnt } Prioridad | ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
