class UserListModel {
  final String uid;
  final String userName;
  final String email;
  final String phoneNumber;

  UserListModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  });

  factory UserListModel.fromMap(Map<String, dynamic> map) {
    return UserListModel(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
