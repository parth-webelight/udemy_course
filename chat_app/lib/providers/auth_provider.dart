import 'package:chat_app/model/auth_state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = NotifierProvider<AuthNotifier, AuthStateModel>(() {
  return AuthNotifier();
});

final currentUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class AuthNotifier extends Notifier<AuthStateModel> {
  final _firebase = FirebaseAuth.instance;

  @override
  AuthStateModel build() {
    return const AuthStateModel();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateUserName(String userName) {
    state = state.copyWith(userName: userName);
  }

  void toggleMode() {
    state = state.copyWith(isLogin: !state.isLogin);
  }

  Future<String?> submit() async {
    state = state.copyWith(isLoading: true);
    
    try {
      UserCredential userCredential;
      if (state.isLogin) {
        userCredential = await _firebase.signInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
      } else {
        userCredential = await _firebase.createUserWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
              'username': state.userName,
              'email': state.email,
            });
      }
      state = state.copyWith(isLoading: false);
      return null; 
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      return e.message ?? 'Authentication failed.';
    }
  }

  Future<void> signOut() async {
    await _firebase.signOut();
  }
}


// final userDataProvider = FutureProvider.family<UserModel?, String>((ref, uid) async {
//   if (uid.isEmpty) return null;
  
//   try {
//     final userDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get();
    
//     if (userDoc.exists) {
//       final data = userDoc.data()!;
//       return UserModel.fromMap({
//         'uid': uid,
//         'username': data['username'],
//         'email': data['email'],
//       });
//     }
//   } catch (e) {
//     debugPrint('Error loading user data: $e');
//   }
//   return null;
// });