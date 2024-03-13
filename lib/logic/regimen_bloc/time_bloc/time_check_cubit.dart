// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';

Stream<DateTime> secondStream() {
  return Stream.periodic(Duration(seconds: 1), (x) => DateTime.now());
}

class TimeCheckCubit extends Cubit<int> {
  final Stream<DateTime> ticker;
  StreamSubscription<DateTime>? _tickerSubscription;

  TimeCheckCubit({required Stream<DateTime> ticker})
      : ticker = ticker,
        super(0) {
    _tickerSubscription = ticker.listen((duration) => emit(state));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
