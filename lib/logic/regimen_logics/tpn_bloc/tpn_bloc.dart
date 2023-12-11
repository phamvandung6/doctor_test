import 'package:bloc/bloc.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:equatable/equatable.dart';

part 'tpn_event.dart';
part 'tpn_state.dart';

class TpnBloc extends Bloc<TpnEvent, TpnState> {
  TpnBloc() : super(const TpnInitial(status: TPNStatus.firstAsk)) {
    on<TPNStatusChange>((event, emit) {
      emit(TpnInitial(status: event.status));
    });
  }
}
