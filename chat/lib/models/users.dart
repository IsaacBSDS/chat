class UserModel {
  final bool online;
  final String username;
  final String name;
  final String uid;

  UserModel({
    required this.online,
    required this.username,
    required this.name,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        username: json["username"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "online": online,
        "uid": uid,
      };
}
