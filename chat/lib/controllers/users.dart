import 'package:chat/data/uses_cases/users_list.dart';
import 'package:chat/models/users.dart';
import 'package:chat/models/users_list_response.dart';
import 'package:flutter/material.dart';

class UsersController extends ChangeNotifier {
  late UserListUseCase userListUseCase;

  UsersController({required this.userListUseCase});

  UsersListResponse usersListResponse = UsersListResponse();

  Future<void> listAllUsers() async {
    try {
      usersListResponse = await userListUseCase.call();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  bool get isUsersListNotEmpty {
    return usersListResponse.users != null &&
        usersListResponse.users!.isNotEmpty;
  }

  updateUsersList(UserModel user) {
    if (isUsersListNotEmpty) {
      final List<UserModel> users = usersListResponse.users!;
      final UserModel userFound = users.firstWhere((e) => e.uid == user.uid);
      final int indexOfUser = users.indexOf(userFound);
      users.removeWhere((element) => element.uid == userFound.uid);
      users.insert(indexOfUser, user);
      usersListResponse = usersListResponse.copyWith(users: users);
      notifyListeners();
    }
  }
}
