@EndUserText.label: 'ENTIDAD ABSTRACT: Cambio estatus'
define abstract entity ZEA_CAM_ST_RMP367

{
  @EndUserText.label: 'Cambio Estatus'
  @Consumption.valueHelpDefinition: [ {
      entity.name: 'ZVH_STAT_RMP637',
      entity.element: 'StatusCode',
      useForValidation: true
    } ]
  status : zde_estatus;
  @EndUserText.label: 'Agrera Observacion'
  text   : zde_text_obsv;

}
