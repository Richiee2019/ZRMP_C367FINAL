CLASS zcl_mensajes_incidente_rmp367 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .
    INTERFACES if_abap_behv_message .

    CONSTANTS: gc_msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',

               BEGIN OF estatus_invalido,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '001',
                 attr1 TYPE scx_attrname VALUE 'MV_ESTATUS',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF estatus_invalido,

               BEGIN OF titulo_vacio,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '002',
                 attr1 TYPE scx_attrname VALUE 'MV_TITU_VACIO',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF titulo_vacio,

               BEGIN OF descrip_vacio,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '003',
                 attr1 TYPE scx_attrname VALUE 'MV_DESCRIP',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF descrip_vacio,

               BEGIN OF prio_vacio,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '004',
                 attr1 TYPE scx_attrname VALUE 'MV_PRIORIDAD',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF prio_vacio,

               BEGIN OF estatus_vacio,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '005',
                 attr1 TYPE scx_attrname VALUE 'MV_ESTATUS_V',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF estatus_vacio,

               BEGIN OF fec_cre_vacio,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '006',
                 attr1 TYPE scx_attrname VALUE 'MV_FEC_CREA',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF fec_cre_vacio,

               BEGIN OF fec_cambio_vacio,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '006',
                 attr1 TYPE scx_attrname VALUE 'MV_FEC_CAMB',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF fec_cambio_vacio,

               BEGIN OF fec_cambio_menor_crea,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '007',
                 attr1 TYPE scx_attrname VALUE 'MV_FEC_CAMB_CREA',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF fec_cambio_menor_crea,

               BEGIN OF fec_crea_fut,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '008',
                 attr1 TYPE scx_attrname VALUE 'MV_FEC_CREA_FUT',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF fec_crea_fut,
               BEGIN OF estatus_no_cambia,
                 msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP367',
                 msgno TYPE symsgno VALUE '009',
                 attr1 TYPE scx_attrname VALUE 'MV_ESTATUS',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF estatus_no_cambia.

    METHODS constructor
      IMPORTING
        textid      LIKE if_t100_message=>t100key OPTIONAL
        attr1       TYPE string OPTIONAL
        attr2       TYPE string OPTIONAL
        attr3       TYPE string OPTIONAL
        attr4       TYPE string OPTIONAL
        previous    LIKE previous OPTIONAL
        begin_date  TYPE /dmo/begin_date OPTIONAL
        end_date    TYPE /dmo/end_date OPTIONAL
        estatus     TYPE zde_estatus OPTIONAL
        severity    TYPE if_abap_behv_message=>t_severity OPTIONAL
        uname       TYPE syuname OPTIONAL
        change_date TYPE  /dmo/end_date OPTIONAL.


    DATA:
      mv_attr1         TYPE string,
      mv_attr2         TYPE string,
      mv_attr3         TYPE string,
      mv_attr4         TYPE string,
      mv_begin_date    TYPE /dmo/begin_date,
      mv_end_date      TYPE /dmo/end_date,
      mv_estatus       TYPE zde_estatus,
      mv_currency_code TYPE /dmo/currency_code,
      mv_uname         TYPE syuname,
      mv_fec_camb_crea TYPE /dmo/begin_date.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mensajes_incidente_rmp367 IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->mv_attr1                 = attr1.
    me->mv_attr2                 = attr2.
    me->mv_attr3                 = attr3.
    me->mv_attr4                 = attr4.
    me->mv_begin_date            = begin_date.
    me->mv_end_date              = end_date.
    me->mv_estatus               = estatus.
    me->mv_uname                 = uname.
    me->mv_fec_camb_crea         = change_date.

    if_abap_behv_message~m_severity = severity.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
