CLASS zcl_mensajes_incidente_rmp367 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .
    INTERFACES if_abap_behv_message .

    CONSTANTS: gc_msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP36',

*    CONSTANTS:
      BEGIN OF customer_unkown,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'MV_CUSTOMER_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF customer_unkown,

      BEGIN OF agency_unkown,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'MV_AGENCY_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF agency_unkown,

      BEGIN OF begin_date_bef_end_date,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'MV_BEGIN_DATE',
        attr2 TYPE scx_attrname VALUE 'MV_END_DATE',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF begin_date_bef_end_date,

      BEGIN OF begin_date_on_or_bef_sysdate,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'MV_BEGIN_DATE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF begin_date_on_or_bef_sysdate,

      BEGIN OF status_invalid,
        msgid TYPE symsgid VALUE 'ZCLASE_MSJ_RMP36',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'MV_STATUS',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF status_invalid,
      BEGIN OF discount_invalid,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF discount_invalid,

      BEGIN OF enter_begin_date,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_begin_date,

      BEGIN OF enter_end_date,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_end_date,

      BEGIN OF enter_agency_id,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_agency_id,

      BEGIN OF enter_customer_id,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_customer_id,

      BEGIN OF enter_connection_id,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '011',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_connection_id,

      BEGIN OF no_flight_exists,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '012',
        attr1 TYPE scx_attrname VALUE 'MV_CARRIER_ID',
        attr2 TYPE scx_attrname VALUE 'MV_FLIGHT_DATE',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_flight_exists,

      BEGIN OF supplement_unknown,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '013',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF supplement_unknown,

      BEGIN OF enter_supplement_id,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '014',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_supplement_id,

      BEGIN OF enter_airline_id,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '016',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_airline_id,

      BEGIN OF enter_flight_date,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '017',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF enter_flight_date,

      BEGIN OF not_sufficient_numbers,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '018',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_sufficient_numbers,

      BEGIN OF number_range_depleted,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '019',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF number_range_depleted,

      BEGIN OF not_authorized,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '020',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_authorized,

      BEGIN OF not_authorized_for_agencyID,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '021',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_authorized_for_agencyID,

      BEGIN OF currency_required,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '022',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF currency_required,

      BEGIN OF currency_not_existing,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '023',
        attr1 TYPE scx_attrname VALUE 'MV_CURRENCY_CODE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF currency_not_existing,

      BEGIN OF booking_fee_invalid,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '024',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF booking_fee_invalid,

      BEGIN OF flight_price_invalid,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '025',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF flight_price_invalid,

      BEGIN OF suppl_price_invalid,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '026',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF suppl_price_invalid.


    METHODS constructor
      IMPORTING
        textid                LIKE if_t100_message=>t100key OPTIONAL
        attr1                 TYPE string OPTIONAL
        attr2                 TYPE string OPTIONAL
        attr3                 TYPE string OPTIONAL
        attr4                 TYPE string OPTIONAL
        previous              LIKE previous OPTIONAL
        begin_date            TYPE /dmo/begin_date OPTIONAL
        end_date              TYPE /dmo/end_date OPTIONAL
        status                TYPE zde_estatus OPTIONAL
        severity              TYPE if_abap_behv_message=>t_severity OPTIONAL
        uname                 TYPE syuname OPTIONAL.


    DATA:
      mv_attr1                 TYPE string,
      mv_attr2                 TYPE string,
      mv_attr3                 TYPE string,
      mv_attr4                 TYPE string,
      mv_begin_date            TYPE /dmo/begin_date,
      mv_end_date              TYPE /dmo/end_date,
      mv_status                TYPE zde_estatus,
      mv_currency_code         TYPE /dmo/currency_code,
      mv_uname                 TYPE syuname.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MENSAJES_INCIDENTE_RMP367 IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->mv_attr1                 = attr1.
    me->mv_attr2                 = attr2.
    me->mv_attr3                 = attr3.
    me->mv_attr4                 = attr4.
    me->mv_begin_date            = begin_date.
    me->mv_end_date              = end_date.
    me->mv_status                = status.
    me->mv_uname                 = uname.

    if_abap_behv_message~m_severity = severity.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
