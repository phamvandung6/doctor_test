import 'package:flutter/material.dart';

class TimeCheck extends StatelessWidget {
  final DateTime time;
  final bool isCheck;

  const TimeCheck({Key? key, required this.time, required this.isCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          Text(
            'Bạn phải đợi đến ${time.add(const Duration(hours: 4))}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.check,
            color: isCheck ? Colors.green : Colors.grey,
          ),
        ],
      ),
    );
  }
}
