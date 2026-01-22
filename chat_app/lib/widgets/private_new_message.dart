// ignore_for_file: deprecated_member_use

import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/providers/private_chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivateNewMessage extends StatelessWidget {
  final UserModel receiver;

  const PrivateNewMessage({super.key, required this.receiver});

  void _submitButton(WidgetRef ref, TextEditingController controller, BuildContext context) async {
    final messageNotifier = ref.read(privateMessageControllerProvider.notifier);
    messageNotifier.updateText(controller.text);
    
    final error = await messageNotifier.sendPrivateMessage(receiver);
    
    if (error != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      controller.clear();
      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    
    return Consumer(
      builder: (context, ref, child) {
        final messageState = ref.watch(privateMessageControllerProvider);
        final messageController = TextEditingController();
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: messageController,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Message ${receiver.username}...',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: screenWidth * 0.04,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenWidth * 0.03,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: messageState.isLoading ? null : () => _submitButton(ref, messageController, context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: messageState.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}