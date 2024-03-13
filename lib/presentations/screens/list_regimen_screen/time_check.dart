import 'dart:async';

import 'package:doctor_test/logic/export_bloc.dart';
import 'package:flutter/material.dart';

class TimeCheck extends StatefulWidget {
  final DateTime time;
  final Function(Timer timer) onDone;
  const TimeCheck({
    Key? key,
    required this.time,
    required this.onDone,
  }) : super(key: key);
  @override
  State<TimeCheck> createState() => _TimeCheck();
}

class _TimeCheck extends State<TimeCheck> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), widget.onDone);
    // startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (DateTime.now().hour == widget.time.hour &&
          DateTime.now().minute == widget.time.minute &&
          DateTime.now().second == widget.time.second) {
        context.read<MouthBloc>().add(CheckingTime(time: widget.time));
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Text(
            'Kiểm tra lại lượng glucose sau ${widget.time.hour}:${widget.time.minute}:${widget.time.second} ngày ${widget.time.day}/${widget.time.month}/${widget.time.year}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.timer,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
