@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ENTIDAD-ASOC: Historial Incidente'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZR_INHIS_RMP367
  as select from zbdt_in_h_rmp367
  association to parent ZR_INC_RMP367 as _Incidente on $projection.IncUuid = _Incidente.IncUuid
{
  key his_uuid              as HisUuid,
  key inc_uuid              as IncUuid,
      his_id                as HisId,
      previous_status       as PreviousStatus,
      new_status            as NewStatus,
      text                  as Text,
      local_created_by      as LocalCreatedBy,
      local_created_at      as LocalCreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,
      _Incidente
}
