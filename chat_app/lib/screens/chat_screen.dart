import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/chat_provider.dart';
import '../widgets/sender_bubble.dart';
import '../widgets/receiver_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String currentUserUid;
  final String tappedUserUid;

  const ChatScreen({
    super.key,
    required this.name,
    required this.currentUserUid,
    required this.tappedUserUid,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // USE AI
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text(
          widget.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),

      body: Consumer(
        builder: (context, ref, _) {
          final chatState = ref.watch(chatProvider(widget.tappedUserUid));
          final chatNotifier = ref.read(
            chatProvider(widget.tappedUserUid).notifier,
          );
          // USE AI
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (chatState.messages.isNotEmpty) {
              _scrollToBottom();
            }
          });

          return Column(
            children: [
              Expanded(
                child: chatState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.teal),
                      )
                    : chatState.messages.isEmpty
                    ? Center(
                        child: Text(
                          "No Messages Yet!",
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: chatState.messages.length,
                        itemBuilder: (context, index) {
                          final msg = chatState.messages[index];
                          final isMe = msg.senderId == widget.currentUserUid;

                          return isMe
                              ? SenderBubble(
                                  text: msg.message,
                                  timestamp: msg.timestamp,
                                )
                              : ReceiverBubble(
                                  text: msg.message,
                                  timestamp: msg.timestamp,
                                );
                        },
                      ),
              ),

              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          cursorColor: Colors.teal,
                          onChanged: chatNotifier.updateCurrentMessage,
                          decoration: InputDecoration(
                            hintText: "Type a message",
                            filled: true,
                            fillColor: const Color(0xFFF2F3F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      CircleAvatar(
                        backgroundColor: chatState.isSending
                            ? Colors.grey
                            : Colors.teal,
                        child: chatState.isSending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.send),
                                color: Colors.white,
                                onPressed: () {
                                  final state = ref.read(
                                    chatProvider(widget.tappedUserUid),
                                  );
                                  if (_messageController.text
                                          .trim()
                                          .isNotEmpty &&
                                      !state.isSending) {
                                    ref
                                        .read(
                                          chatProvider(
                                            widget.tappedUserUid,
                                          ).notifier,
                                        )
                                        .sendMessage();
                                    _messageController.clear();
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}