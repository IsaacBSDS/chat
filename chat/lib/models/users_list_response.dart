import 'package:chat/models/users.dart';

class UsersListResponse {
  UsersListResponse({
    this.ok,
    this.count,
    this.users,
    this.from,
  });

  final bool? ok;
  final int? count;
  final List<UserModel>? users;
  final int? from;

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      UsersListResponse(
        ok: json["ok"],
        count: json["count"],
        users: List<UserModel>.from(
            json["users"].map((x) => UserModel.fromJson(x))),
        from: json["from"],
      );

  UsersListResponse copyWith({
    bool? ok,
    int? count,
    List<UserModel>? users,
    int? from,
  }) =>
      UsersListResponse(
        ok: ok ?? this.ok,
        count: count ?? this.count,
        users: users ?? this.users,
        from: from ?? this.from,
      );
}
