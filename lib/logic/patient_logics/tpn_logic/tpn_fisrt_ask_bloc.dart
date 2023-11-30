import 'package:doctor_test/data/models/medical/procedure_state.dart';
import 'package:doctor_test/logic/cubit/tpn_procedure_online_cubit.dart';
import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:doctor_test/utils/form_validator.dart';

class TPNFirstAskBloc extends FormBloc<String, String> {
  final TPNProcedureOnlineCubit procedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Có', 'Không'],
    validators: [FormValidatorUtils.required],
  );

  TPNFirstAskBloc({
    required this.procedureOnlineCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        yesOrNoInsulin,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print('onSubmitting');
    num weight = procedureOnlineCubit.weight;
    ProcedureState procedureState = ProcedureState(
      status: yesOrNoInsulin.value == 'Yes'
          ? ProcedureStatus.yesInsulin
          : ProcedureStatus.noInsulin,
      slowInsulinType: InsulinType.lantus,
      weight: weight,
    );
    //update sonde status
    try {
      await procedureOnlineCubit.updateProcedureStateStatus(
        procedureState,
      );
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
