@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROOT:  Incidente principal'
@Metadata.allowExtensions: true
define root view entity ZR_INC_RMP367
  as select from zbdt_inc_rmp367 //Tabla incidentes principal
  composition [0..*] of ZR_INHIS_RMP367 as _Historial
{
  key inc_uuid              as IncUuid,
      incident_id           as IncidentId,
      title                 as Title,
      description           as Description,
      status                as Status,
      priority              as Priority,
      creation_date         as CreationDate,
      changed_date          as ChangedDate,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      _Historial
}
