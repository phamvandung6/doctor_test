part of 'mouth_bloc.dart';

class MouthState extends Equatable {
  const MouthState({
    this.regimenStatus = RegimenStatus.checkingGlucose,
    this.glucoseLevel = 0.0,
    this.doneList = const <bool>[],
  });
  final RegimenStatus regimenStatus;
  final double glucoseLevel;
  final List<bool> doneList;
  MouthState copyWith({
    RegimenStatus? regimenStatus,
    double? glucoseLevel,
    List<bool>? doneList,
  }) {
    return MouthState(
      regimenStatus: regimenStatus ?? this.regimenStatus,
      glucoseLevel: glucoseLevel ?? this.glucoseLevel,
      doneList: doneList ?? this.doneList,
    );
  }

  @override
  List<Object> get props => [regimenStatus, glucoseLevel, doneList];
}
