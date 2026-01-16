import 'package:flutter/material.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  String confirmText = "Yes",
  String cancelText = "Cancel",
  bool showCancelButton = true,
  IconData icon = Icons.info,
  Color iconColor = Colors.blue,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          if (showCancelButton)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(cancelText),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
