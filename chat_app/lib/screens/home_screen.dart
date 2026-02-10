import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/user_list_screen.dart';
import 'package:chat_app/widgets/logout_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String getOtherUserId(List<String> participants, String currentUser) {
    return participants.firstWhere((uid) => uid != currentUser);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          "Chats",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  showLogoutDialog(context: context, ref: ref);
                },
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserListScreen()),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Consumer(
        builder: (context, ref, child) {
          final chatRoomsAsync = ref.watch(chatListProvider);

          return chatRoomsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            ),

            error: (e, st) => Center(
              child: Text(
                "Error loading chats",
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),

            data: (rooms) {
              if (rooms.isEmpty) {
                return Center(
                  child: Text(
                    "No Chats Yet",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  final otherUserUid = getOtherUserId(
                    room.participants,
                    currentUser,
                  );
                  final userNameAsync = ref.watch(
                    userNameProvider(otherUserUid),
                  );

                  return userNameAsync.when(
                    loading: () =>  ListTile(
                    
                       contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.shade300,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          'Loading...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ),

                    error: (e, st) => const ListTile(
                      leading: CircleAvatar(child: Icon(Icons.error)),
                      title: Text("Error loading name"),
                    ),

                    data: (name) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),

                       leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFFE0F2F1),
                        child: Text(
                          name[0].toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: Colors.teal.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                        title: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        subtitle: Text(
                          room.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        trailing: Text(
                          "${room.lastMessageTime.hour.toString().padLeft(2, '0')}:"
                          "${room.lastMessageTime.minute.toString().padLeft(2, '0')}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                name: name,
                                currentUserUid: currentUser,
                                tappedUserUid: otherUserUid,
                              ),
                            ),
                          );
                        },
                      );
                    },
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