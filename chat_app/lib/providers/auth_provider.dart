import 'package:chat_app/models/auth_state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthProvider, AuthStateModel>(
      (ref) => AuthProvider(),
    );

final currentUserIdProvider = Provider<String?>((ref) {
  return FirebaseAuth.instance.currentUser?.uid;
});

class AuthProvider extends StateNotifier<AuthStateModel> {
  AuthProvider()
    : super(
        AuthStateModel(
          userName: "",
          email: "",
          phoneNumber: "",
          password: "",
          isLoading: false,
          isLogin: true,
          isFieldActive: true,
        ),
      );

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateUserName(String value) {
    state = state.copyWith(userName: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void updateLoginState() {
    state = state.copyWith(isLogin: !state.isLogin);
  }

  void updateFieldActive() {
    state = state.copyWith(isFieldActive: !state.isFieldActive);
  }

  Future<String?> submit() async {
    state = state.copyWith(isLoading: true);

    try {
      if (state.isLogin) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
      } else {
        final userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(
              email: state.email,
              password: state.password,
            );
        final user = userCredential.user;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'userName': state.userName,
            'email': state.email,
            'phoneNumber': state.phoneNumber,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return _mapError(e.code);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> logout() async {
    _firebaseAuth.signOut();
  }

  String _mapError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already in use';
      case 'invalid-email':
        return 'Invalid email';
      case 'weak-password':
        return 'Weak password';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      default:
        return 'Authentication failed';
    }
  }
}
