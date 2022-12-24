class UserModel {
  const UserModel({required this.uid, required this.email, required this.isVerified});

  final String? uid;
  final String? email;
  final bool isVerified;
}
