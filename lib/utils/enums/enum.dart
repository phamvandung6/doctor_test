enum Gender {
  male,
  female,
}

enum ProcedureType {
  tpn,
  sonde,
  mouth,
  fasting,
  unknown,
}

enum ProcedureStatus {
  firstAsk,
  noInsulin,
  yesInsulin,
  highInsulin,
  finish,
}

enum MouthProcedureStatus {
  loading,
  firstAsk,
  acuteHyperglycemia, //tăng đường huyết cấp tính
  secondAsk,
  hypoGlycemia, //bị hạ đường huyết
  hypoGlycemiaNoInsulin, //bị hạ đường huyết nhưng không có insulin
  hypoGlycemiaYesInsulin, //bị hạ đường huyết và có insulin
  thirdAsk,
  baseBolus,
  inpatient,
  outpatient,
  inOrOutPatientAsk,
  endocrineConference, //hội chẩn nội tiết
  finish,
}

enum RegimenStatus {
  error,
  checkingGlucose,
  givingInsulin,
  guideMixing,
  done,
}

enum GlucoseEvaluation {
  normal,
  high,
  low,
  superHigh,
  extremelyHigh,
}

enum InsulinType {
  //slow
  glargine,
  levemir,
  lantus,
  nph,
  insulatard,
  slow,

  //fast
  actrapid,
  novoRapid,
  humalogKwikpen,
  fast,
  unknown,
}
