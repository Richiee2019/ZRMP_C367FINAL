@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONSUMO: Incidente'
@Metadata.allowExtensions: true
define root view entity ZRC_INC_RMP367
provider contract transactional_query
  as projection on ZR_INC_RMP367
{
  key IncUuid,
      IncidentId,
      Title,
      Description,
      Status,
      Priority,
      CreationDate,
      ChangedDate,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Historial :redirected to composition child ZRC_INHIS_RMP367
}
