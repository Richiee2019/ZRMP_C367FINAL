@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONSUMO: Historial Incidente'
@Metadata.allowExtensions: true
define view entity ZRC_INHIS_RMP367
  as projection on ZR_INHIS_RMP367
{
  key HisUuid,
  key IncUuid,
      HisId,
      PreviousStatus,
      NewStatus,
      Text,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Incidente : redirected to parent ZRC_INC_RMP367
}
