@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH: Ayuda Estatus Incidente'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'StatusCode'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@VDM.viewType: #COMPOSITE
@Search.searchable: true


define view entity ZVH_STAT_RMP637
  as select from zbdt_est_rmp367

{
      @ObjectModel.text.element:['StatusDescription']
  key status_code        as StatusCode,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text:true
      status_description as StatusDescription
}
