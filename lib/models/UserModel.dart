class UserList {
  static List<UserModel> user = [];
}

class UserModel {
  final String username;
  final String phone;
  final String name;
  final String imageUrl;

  String rechargeBalance;
  String driveBalance;
  final String password;
  final String pin;
  UserModel({
    required this.password,
    required this.username,
    required this.phone,
    required this.name,
    required this.imageUrl,
    required this.rechargeBalance,
    required this.driveBalance,
    required this.pin,
  });
}
