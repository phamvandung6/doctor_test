part of 'tpn_bloc.dart';

abstract class TpnState extends Equatable {
  final TPNStatus status;
  const TpnState({required this.status});

  @override
  List<Object> get props => [status];
}

class TpnInitial extends TpnState {
  const TpnInitial({required super.status});
}
