CLASS lhc_Incidente DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF mc_estatus,
                 open        TYPE zde_status2_lgl VALUE 'OP',
                 in_progress TYPE zde_status2_lgl VALUE 'IP',
                 pending     TYPE zde_status2_lgl VALUE 'PE',
                 completed   TYPE zde_status2_lgl VALUE 'CO',
                 closed      TYPE zde_status2_lgl VALUE 'CL',
                 canceled    TYPE zde_status2_lgl VALUE 'CN',
               END OF mc_estatus.


  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Incidente RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Incidente RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Incidente RESULT result.

    METHODS CambioStatus FOR MODIFY
      IMPORTING keys FOR ACTION Incidente~CambioStatus RESULT result.

    METHODS setHistory FOR MODIFY
      IMPORTING keys FOR ACTION Incidente~setHistory.

    METHODS setDefaultValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Incidente~setDefaultValues.

    METHODS setDefaultHistory FOR DETERMINE ON SAVE
      IMPORTING keys FOR Incidente~setDefaultHistory.

    METHODS validarCamposObligatorios FOR VALIDATE ON SAVE
      IMPORTING keys FOR Incidente~validarCamposObligatorios.

    METHODS validarfechas FOR VALIDATE ON SAVE
      IMPORTING keys FOR Incidente~validarfechas.

    METHODS get_history_index EXPORTING ev_incuuid      TYPE sysuuid_x16
                              RETURNING VALUE(rv_index) TYPE zde_id_his.

ENDCLASS.

CLASS lhc_Incidente IMPLEMENTATION.

  METHOD get_instance_features.

    DATA lv_history_index TYPE zde_id_his.

    READ ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
       ENTITY Incidente
         FIELDS ( Status )
         WITH CORRESPONDING #( keys )
       RESULT DATA(incidentes)
       FAILED failed.

    " Desabiltar el boton cambio de estatus en la creacion del incidente
    DATA(lv_create_action) = lines( incidentes ).
    IF lv_create_action EQ 1.
      lv_history_index = get_history_index( IMPORTING ev_incuuid = incidentes[ 1 ]-IncUUID ).
    ELSE.
      lv_history_index = 1.
    ENDIF.

    result = VALUE #( FOR incidente IN incidentes
                          ( %tky                   = incidente-%tky
                            %action-CambioStatus   = COND #( WHEN incidente-Status = mc_estatus-completed OR
                                                                  incidente-Status = mc_estatus-closed    OR
                                                                  incidente-Status = mc_estatus-canceled  OR
                                                                  lv_history_index = 0
                                                             THEN if_abap_behv=>fc-o-disabled
                                                             ELSE if_abap_behv=>fc-o-enabled )

                            %assoc-_Historial       = COND #( WHEN incidente-Status = mc_estatus-completed OR
                                                                 incidente-Status = mc_estatus-closed    OR
                                                                 incidente-Status = mc_estatus-canceled  OR
                                                                 lv_history_index = 0
                                                            THEN if_abap_behv=>fc-o-disabled
                                                            ELSE if_abap_behv=>fc-o-enabled )
                          ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CambioStatus.


    DATA: lt_updated_root_entity TYPE TABLE FOR UPDATE zr_inc_rmp367,
          lt_association_entity  TYPE TABLE FOR CREATE zr_inc_rmp367\_Historial,
          lv_status              TYPE zde_estatus,
          lv_text                TYPE zde_text_obsv,
          lv_exception           TYPE string,
          lv_error               TYPE c,
          ls_incident_history    TYPE zbdt_in_h_rmp367,
          lv_max_his_id          TYPE zde_id_his,
          lv_wrong_status        TYPE zde_estatus.


    READ ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
         ENTITY Incidente
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(incidentes)
         FAILED failed.

    LOOP AT incidentes ASSIGNING FIELD-SYMBOL(<incident>).
      " obtienes el estatus
      lv_status = keys[ KEY id %tky = <incident>-%tky ]-%param-status.

      " Validación ya que no es posible cambiatr el estatus dadas cieratas condiciones
      IF <incident>-Status EQ mc_estatus-pending AND lv_status EQ mc_estatus-closed OR
         <incident>-Status EQ mc_estatus-pending AND lv_status EQ mc_estatus-completed.
        " Estabelces autorizacion
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.

        lv_wrong_status = lv_status.
        " Mensajes de eeror personalizado
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>estatus_invalido
                                                                  estatus  = lv_wrong_status
                                                                  severity = if_abap_behv_message=>severity-error )

                         %op-%action-CambioStatus = if_abap_behv=>mk-on

                         ) TO reported-incidente.

        lv_error = abap_true.
        EXIT.
      ENDIF.
      IF <incident>-Status EQ mc_estatus-canceled OR <incident>-Status EQ mc_estatus-closed OR
         <incident>-Status EQ mc_estatus-completed.

        APPEND VALUE #( %tky = <incident>-%tky
                                %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>estatus_no_cambia
                                                                          severity = if_abap_behv_message=>severity-error )

                                 %op-%action-CambioStatus = if_abap_behv=>mk-on

                                 ) TO reported-incidente.

        lv_error = abap_true.
        EXIT.

      ENDIF.

      APPEND VALUE #( %tky = <incident>-%tky
                      ChangedDate = cl_abap_context_info=>get_system_date( )
                      Status = lv_status ) TO lt_updated_root_entity.

      " Obtener el texto
      lv_text = keys[ KEY id %tky = <incident>-%tky ]-%param-text.

      lv_max_his_id = get_history_index(
                  IMPORTING
                    ev_incuuid = <incident>-IncUUID ).

      IF lv_max_his_id IS INITIAL.
        ls_incident_history-his_id = 1.
      ELSE.
        ls_incident_history-his_id = lv_max_his_id + 1.
      ENDIF.

      ls_incident_history-new_status = lv_status.
      ls_incident_history-text = lv_text.

      TRY.
          ls_incident_history-inc_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error INTO DATA(lo_error).
          lv_exception = lo_error->get_text(  ).
      ENDTRY.

      IF ls_incident_history-his_id IS NOT INITIAL.
*
        APPEND VALUE #( %tky = <incident>-%tky
                        %target = VALUE #( (  HisUUID = ls_incident_history-inc_uuid
                                              IncUUID = <incident>-IncUUID
                                              HisID = ls_incident_history-his_id
                                              PreviousStatus = <incident>-Status
                                              NewStatus = ls_incident_history-new_status
                                              Text = ls_incident_history-text ) )
                                               ) TO lt_association_entity.
      ENDIF.
    ENDLOOP.
    UNASSIGN <incident>.

    " se interumpe por que el cambio de estatus de penciente a completado o a cerrado no es permitido
    CHECK lv_error IS INITIAL.

    " Se modofica el estatus de la entidad ROOT
    MODIFY ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
    ENTITY Incidente
    UPDATE  FIELDS ( ChangedDate
                     Status )
    WITH lt_updated_root_entity.

    FREE incidentes. " Libera las entidad de incidentes

    MODIFY ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
     ENTITY Incidente
     CREATE BY \_Historial FIELDS (   HisUUID
                                      IncUUID
                                      HisID
                                      PreviousStatus
                                      NewStatus
                                      Text )
            AUTO FILL CID
        WITH lt_association_entity
     MAPPED mapped
     FAILED failed
     REPORTED reported.

    " Lee la enidad de incidentes ROOT actualizadas
    READ ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
    ENTITY Incidente
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT incidentes
    FAILED failed.

    " Actualiza la interfaz del usuario
    result = VALUE #( FOR incidente IN incidentes ( %tky = incidente-%tky
                                                  %param = incidente ) ).

  ENDMETHOD.

  METHOD setHistory.

    DATA: lt_updated_root_entity TYPE TABLE FOR UPDATE zr_inc_rmp367,
          lt_association_entity  TYPE TABLE FOR CREATE zr_inc_rmp367\_Historial,
          lv_exception           TYPE string,
          ls_incident_history    TYPE zbdt_in_h_rmp367,
          lv_max_his_id          TYPE zde_his_id_lgl.


    READ ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
         ENTITY Incidente
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(incidentes).

    LOOP AT incidentes ASSIGNING FIELD-SYMBOL(<incident>).
      lv_max_his_id = get_history_index( IMPORTING ev_incuuid = <incident>-IncUUID ).

      IF lv_max_his_id IS INITIAL.
        ls_incident_history-his_id = 1.
      ELSE.
        ls_incident_history-his_id = lv_max_his_id + 1.
      ENDIF.

      TRY.
          ls_incident_history-inc_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error INTO DATA(lo_error).
          lv_exception = lo_error->get_text(  ).
      ENDTRY.

      IF ls_incident_history-his_id IS NOT INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky
                        %target = VALUE #( (  HisUUID = ls_incident_history-inc_uuid
                                              IncUUID = <incident>-IncUUID
                                              HisID = ls_incident_history-his_id
                                              NewStatus = <incident>-Status
                                              Text = 'Primer Incidente' ) )
                                               ) TO lt_association_entity.
      ENDIF.
    ENDLOOP.
    UNASSIGN <incident>.

    FREE incidentes.

    MODIFY ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
     ENTITY Incidente
     CREATE BY \_Historial FIELDS ( HisUUID
                                  IncUUID
                                  HisID
                                  PreviousStatus
                                  NewStatus
                                  Text )
        AUTO FILL CID
        WITH lt_association_entity.


  ENDMETHOD.

  METHOD setDefaultValues.
    " Para establecer valores por default

    " Leemos la estradas de la entidad raiz
    READ ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
    ENTITY Incidente
    FIELDS ( CreationDate
             Status ) WITH CORRESPONDING #( keys )
             RESULT DATA(incidentes).

    " Borramos donde la fecha de creacion este llena
    DELETE incidentes WHERE CreationDate IS NOT INITIAL.

    CHECK  incidentes IS NOT INITIAL.

    " Obtenemos el ultimo de los ID de los incidentes
    SELECT FROM zbdt_inc_rmp367
    FIELDS MAX( incident_id ) AS incidente_maximo
    WHERE incident_id IS NOT NULL
    INTO @DATA(lv_max_id_incidente).

    IF lv_max_id_incidente IS NOT INITIAL.
      lv_max_id_incidente += 1.
    ELSE.
      lv_max_id_incidente = 1.
    ENDIF.

    " Modifica y establece valores inicales en ciertos campos
    MODIFY ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
      ENTITY Incidente
      UPDATE
      FIELDS ( IncidentID
               CreationDate
               Status )
      WITH VALUE #(  FOR incidente IN incidentes ( %tky = incidente-%tky
                                                 IncidentID = lv_max_id_incidente
                                                 CreationDate = cl_abap_context_info=>get_system_date( )
                                                 Status       = mc_estatus-open )  ).

  ENDMETHOD.

  METHOD setDefaultHistory.

    MODIFY ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
    ENTITY Incidente
    EXECUTE setHistory
       FROM CORRESPONDING #( keys ).

  ENDMETHOD.

  METHOD get_history_index.

    " Llenar datos del historial
    SELECT FROM zbdt_in_h_rmp367
      FIELDS MAX( his_id ) AS max_his_id
      WHERE inc_uuid EQ @ev_incuuid AND
            his_uuid IS NOT NULL
      INTO @rv_index.

  ENDMETHOD.

  METHOD validarCamposObligatorios.

    READ ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
         ENTITY Incidente
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(incidentes).

    LOOP AT incidentes ASSIGNING FIELD-SYMBOL(<incident>).

      IF <incident>-Title IS INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>titulo_vacio
                                                                  severity = if_abap_behv_message=>severity-error
                                                                )
                       %element-title = if_abap_behv=>mk-on
                      ) TO reported-incidente.

      ENDIF.

      IF <incident>-Description IS INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>descrip_vacio
                                                                  severity = if_abap_behv_message=>severity-error
                                                                )
                       %element-Description = if_abap_behv=>mk-on
                      ) TO reported-incidente.

      ENDIF.
      IF <incident>-Priority IS INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>prio_vacio
                                                                  severity = if_abap_behv_message=>severity-error
                                                                )
                       %element-Priority = if_abap_behv=>mk-on
                      ) TO reported-incidente.

      ENDIF.
      IF <incident>-Status IS INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>estatus_vacio
                                                                  severity = if_abap_behv_message=>severity-error
                                                                )
                       %element-Status = if_abap_behv=>mk-on
                      ) TO reported-incidente.

      ENDIF.
      IF <incident>-CreationDate IS INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>fec_cre_vacio
                                                                  severity = if_abap_behv_message=>severity-error
                                                                )
                       %element-CreationDate = if_abap_behv=>mk-on
                      ) TO reported-incidente.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validarfechas.
    READ ENTITIES OF zr_inc_rmp367 IN LOCAL MODE
       ENTITY Incidente
       FIELDS (
             CreationDate
             ChangedDate
              )
       WITH  CORRESPONDING #( keys )
       RESULT DATA(incidentes).

    LOOP AT incidentes ASSIGNING FIELD-SYMBOL(<incident>).

      IF <incident>-ChangedDate IS INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid      = zcl_mensajes_incidente_rmp367=>fec_cambio_vacio
                                                                  change_date = <incident>-ChangedDate
                                                                  severity    = if_abap_behv_message=>severity-error
                                                                )
                       %element-ChangedDate = if_abap_behv=>mk-on
                      ) TO reported-incidente.
      ENDIF.

      IF <incident>-ChangedDate < <incident>-CreationDate AND <incident>-CreationDate IS NOT INITIAL
                                                          AND <incident>-ChangedDate IS NOT INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>fec_cambio_menor_crea
                                                                  change_date = <incident>-ChangedDate
                                                                  severity = if_abap_behv_message=>severity-error
                                                                )
                       %element-ChangedDate = if_abap_behv=>mk-on
                      ) TO reported-incidente.
      ENDIF.

      IF <incident>-CreationDate > cl_abap_context_info=>get_system_date( ) AND  <incident>-CreationDate IS NOT INITIAL.
        APPEND VALUE #( %tky = <incident>-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = <incident>-%tky
                        %msg = NEW zcl_mensajes_incidente_rmp367( textid   = zcl_mensajes_incidente_rmp367=>fec_crea_fut
                                                                  severity = if_abap_behv_message=>severity-error
                                                                )
                       %element-CreationDate = if_abap_behv=>mk-on
                      ) TO reported-incidente.
      ENDIF.



    ENDLOOP..

  ENDMETHOD.

ENDCLASS.
