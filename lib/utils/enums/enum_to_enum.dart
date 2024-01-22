import 'enum.dart';

class StringToEnum {
  //gender
  static Gender stringToGender(String g) {
    switch (g) {
      case 'Nam':
        return Gender.male;
      default:
        return Gender.female;
    }
  }

  //procedureType
  static ProcedureType stringToProcedureType(String m) {
    switch (m) {
      case 'TPN':
        return ProcedureType.tpn;
      case 'Sonde':
        return ProcedureType.sonde;
      case 'Mouth':
        return ProcedureType.mouth;
      case 'ĐTĐ nhịn ăn':
        return ProcedureType.fasting;
      default:
        return ProcedureType.unknown;
    }
  }

  //sondeStatus
  static ProcedureStatus stringToSondeStatus(String s) {
    switch (s) {
      case 'firstAsk':
        return ProcedureStatus.firstAsk;
      case 'noInsulin':
        return ProcedureStatus.noInsulin;

      case 'yesInsulin':
        return ProcedureStatus.yesInsulin;

      case 'highInsulin':
        return ProcedureStatus.highInsulin;
      case 'finish':
        return ProcedureStatus.finish;

      default:
        return ProcedureStatus.firstAsk;
    }
  }

  //insulinType
  static InsulinType stringToInsulinType(String i) {
    switch (i) {
      //slow
      case 'Slow':
        return InsulinType.slow;
      case 'Glargine':
        return InsulinType.glargine;
      case 'Levemir':
        return InsulinType.levemir;
      case 'Lantus':
        return InsulinType.lantus;
      case 'NPH':
        return InsulinType.nph;
      case 'Insulatard':
        return InsulinType.insulatard;
      //fast
      case 'Fast':
        return InsulinType.fast;

      case 'Actrapid':
        return InsulinType.actrapid;
      case 'NovoRapid':
        return InsulinType.novoRapid;
      case 'Humalog_kwikpen':
        return InsulinType.humalogKwikpen;

      default:
        return InsulinType.unknown;
    }
  }

  //mouthProcedureStatus
  static MouthProcedureStatus stringToMouthProcedureStatus(String s) {
    switch (s) {
      case 'loading':
        return MouthProcedureStatus.loading;
      //ca 1
      case 'firstAsk':
        return MouthProcedureStatus.firstAsk;
      case 'acuteHyperglycemia':
        return MouthProcedureStatus.acuteHyperglycemia;
      //ca 2
      case 'secondAsk':
        return MouthProcedureStatus.secondAsk;
      case 'hypoGlycemia':
        return MouthProcedureStatus.hypoGlycemia;
      case 'hypoGlycemiaNoInsulin':
        return MouthProcedureStatus.hypoGlycemiaNoInsulin;
      case 'hypoGlycemiaYesInsulin':
        return MouthProcedureStatus.hypoGlycemiaYesInsulin;
      //ca 3
      case 'thirdAsk':
        return MouthProcedureStatus.thirdAsk;
      case 'baseBolus':
        return MouthProcedureStatus.baseBolus;
      case 'inpatient':
        return MouthProcedureStatus.inpatient;
      case 'outpatient':
        return MouthProcedureStatus.outpatient;
      case 'in_or_out_patient_ask':
        return MouthProcedureStatus.inOrOutPatientAsk;
      case 'endocrineConference':
        return MouthProcedureStatus.endocrineConference;
      case 'finish':
        return MouthProcedureStatus.finish;
      default:
        return MouthProcedureStatus.firstAsk;
    }
  }

  //FastingStatus
  static ProcedureStatus stringToFastingStatus(String s) {
    switch (s) {
      case 'firstAsk':
        return ProcedureStatus.firstAsk;
      case 'noInsulin':
        return ProcedureStatus.noInsulin;

      case 'yesInsulin':
        return ProcedureStatus.yesInsulin;

      case 'highInsulin':
        return ProcedureStatus.highInsulin;
      case 'finish':
        return ProcedureStatus.finish;
      default:
        return ProcedureStatus.firstAsk;
    }
  }
}
