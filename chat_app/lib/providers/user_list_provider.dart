import 'package:chat_app/models/user_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// GET ALL USERS FROM FIRESTORE
final allUsersProvider = StreamProvider<List<UserListModel>>((ref) {
  return FirebaseFirestore.instance.collection('users').snapshots().map((
    snapshot,
  ) {
    return snapshot.docs
        .map((doc) => UserListModel.fromMap(doc.data()))
        .toList();
  });
}); 