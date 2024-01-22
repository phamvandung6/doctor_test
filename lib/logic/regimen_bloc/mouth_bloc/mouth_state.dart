part of 'mouth_bloc.dart';

class MouthState extends Equatable {
  const MouthState({
    this.regimenStatus = RegimenStatus.checkingGlucose,
    this.glucoseLevel = 0.0,
  });
  final RegimenStatus regimenStatus;
  final double glucoseLevel;
  MouthState copyWith({
    RegimenStatus? regimenStatus,
    double? glucoseLevel,
  }) {
    return MouthState(
      regimenStatus: regimenStatus ?? this.regimenStatus,
      glucoseLevel: glucoseLevel ?? this.glucoseLevel,
    );
  }

  @override
  List<Object> get props => [regimenStatus, glucoseLevel];
}
