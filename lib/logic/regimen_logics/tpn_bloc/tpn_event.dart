part of 'tpn_bloc.dart';

sealed class TpnEvent extends Equatable {
  final TPNStatus status;
  const TpnEvent({required this.status});

  @override
  List<Object> get props => [status];
}

class TPNStatusChange extends TpnEvent {
  const TPNStatusChange({required super.status});

  @override
  List<Object> get props => [status];
}
