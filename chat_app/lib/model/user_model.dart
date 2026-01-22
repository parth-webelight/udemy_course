class UserModel {
  final String uid;
  final String username;
  final String email;

  const UserModel({
    required this.uid,
    required this.username,
    required this.email,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }
}