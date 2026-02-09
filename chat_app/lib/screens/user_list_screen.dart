// ignore_for_file: deprecated_member_use
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/user_list_provider.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Users",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final usersAsync = ref.watch(allUsersProvider);
          final currentUid = ref.watch(currentUserIdProvider);

          return usersAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            ),
            error: (error, _) => Center(
              child: Text(error.toString(), style: GoogleFonts.poppins()),
            ),
            data: (users) {
              final filteredUsers = users
                  .where((u) => u.uid != currentUid)
                  .toList();
              if (filteredUsers.isEmpty) {
                return Center(
                  child: Text(
                    "No users found",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),

                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFFE0F2F1),
                        child: Text(
                          user.userName[0].toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: Colors.teal.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      title: Text(
                        user.userName,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          user.email,
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      trailing: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.teal.shade700,
                          size: 20,
                        ),
                      ),

                      onTap: () {
                        debugPrint("LOGGED USER : $currentUid");
                        debugPrint("TAPPED USER UID : ${user.uid}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              name: user.userName,
                              currentUserUid: currentUid.toString(),
                              tappedUserUid: user.uid,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
