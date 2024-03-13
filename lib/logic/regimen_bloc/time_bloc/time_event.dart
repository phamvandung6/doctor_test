part of 'time_bloc.dart';

abstract class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class TimeStarted extends TimeEvent {}

class TimeTicked extends TimeEvent {}

class TimeDone extends TimeEvent {
  final bool isDone1;
  const TimeDone({required this.isDone1});
  @override
  List<Object> get props => [isDone1];
}
