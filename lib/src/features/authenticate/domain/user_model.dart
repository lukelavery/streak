class UserModel {
  const UserModel({
      required this.uid,
      required this.email,
      required this.isVerified,
      this.name,
      this.photoUrl
    });

  final String? uid;
  final String? email;
  final bool isVerified;
  final String? name;
  final String? photoUrl;
}
