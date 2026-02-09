import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../screens/auth_screen.dart';

Future<void> showLogoutDialog({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        actionsPadding: const EdgeInsets.all(16),

        title: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        content: const Text(
          "Are you sure you want to logout?\nYou will need to login again.",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),

        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);

              ref.read(authProvider.notifier).logout();

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const AuthScreen(),
                ),
                (_) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      );
    },
  );
}
