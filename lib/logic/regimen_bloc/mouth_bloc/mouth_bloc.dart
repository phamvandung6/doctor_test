import 'package:doctor_test/logic/export_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/enums/enum.dart';
part 'mouth_state.dart';
part 'mouth_event.dart';

class MouthBloc extends Bloc<MouthEvent, MouthState> {
  MouthBloc() : super(const MouthState()) {
    on<CheckGlucose>(_onCheckGlucose);
    // on<CheckingTime>(_onCheckingTime);
  }
  void _onCheckGlucose(CheckGlucose event, Emitter<MouthState> emit) {
    if (event.glucoseLevel >= 3.9 && event.glucoseLevel <= 8.3) {
      emit(state.copyWith(
          regimenStatus: RegimenStatus.done, glucoseLevel: event.glucoseLevel));
    } else if (event.glucoseLevel > 8.3 && event.glucoseLevel <= 11.1) {
      emit(state.copyWith(
          regimenStatus: RegimenStatus.waiting,
          glucoseLevel: event.glucoseLevel));
    } else {
      emit(state.copyWith(
          regimenStatus: RegimenStatus.waiting,
          glucoseLevel: event.glucoseLevel));
    }
  }
  // Future<void> _onCheckingTime(CheckingTime event, Emitter<MouthState> emit) async {
  //   // await Future.delayed(Da);
  //   if (event.time == DateTime.now()) {
  //     emit(state.copyWith(regimenStatus: RegimenStatus.givingInsulin));
  //   }
  // }
}
