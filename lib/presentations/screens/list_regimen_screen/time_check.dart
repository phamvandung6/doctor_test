import 'dart:async';

import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/logic/regimen_bloc/mouth_bloc/mouth_bloc.dart';
import 'package:flutter/material.dart';

class TimeCheck extends StatefulWidget {
  final DateTime time;
  const TimeCheck({
    Key? key,
    required this.time,
  }) : super(key: key);
  @override
  State<TimeCheck> createState() => _TimeCheck();
}

class _TimeCheck extends State<TimeCheck> {
  @override
  void initState() {
    super.initState();
    startTimer();
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
    // context.read<MouthBloc>().add(CheckingTime(time: time));
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          Text(
            'Bạn phải đợi đến ${widget.time.hour}:${widget.time.minute}:${widget.time.second}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.check,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
