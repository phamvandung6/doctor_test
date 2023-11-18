import 'package:doctor_test/data/models/room_model.dart';
import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    super.key,
    required this.deleteCallBack,
  });
  final VoidCallback deleteCallBack;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: deleteCallBack,
          child: TextButton.icon(
            onPressed: null,
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            label: const Text(
              'Xóa',
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
